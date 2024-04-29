//
//  NetworkManager.swift
//  JeVis
//
//  Created by Rizki Maulana on 28/04/24.
//

import Foundation

class NetworkRequest {
    func uploadToImageBb(base64ImageData: String, completion: @escaping (String?, Error?) -> Void) {
        let parameters = [
            [
                "key": "image",
                "value": base64ImageData,
                "type": "text"
            ]] as [[String: Any]]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        for param in parameters {
            if param["disabled"] != nil { continue }
            let paramName = param["key"]!
            body += Data("--\(boundary)\r\n".utf8)
            body += Data("Content-Disposition:form-data; name=\"\(paramName)\"".utf8)
            if param["contentType"] != nil {
                body += Data("\r\nContent-Type: \(param["contentType"] as! String)".utf8)
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
                let paramValue = param["value"] as! String
                body += Data("\r\n\r\n\(paramValue)\r\n".utf8)
            } else {
                let paramSrc = param["src"] as! String
                let fileURL = URL(fileURLWithPath: paramSrc)
                if let fileContent = try? Data(contentsOf: fileURL) {
                    body += Data("; filename=\"\(paramSrc)\"\r\n".utf8)
                    body += Data("Content-Type: \"content-type header\"\r\n".utf8)
                    body += Data("\r\n".utf8)
                    body += fileContent
                    body += Data("\r\n".utf8)
                }
            }
        }
        body += Data("--\(boundary)--\r\n".utf8);
        let postData = body
        
        let urlString = "\(Constants.imageBbUploadApi)?key=\(Constants.imageBbApiKey)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil,  URLError(.unknown))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let responseData = json?["data"] as? [String: Any]
                let imageUrl = responseData?["url"] as? String
                completion(imageUrl, nil)
                print("success upload image")
            } catch {
                completion(nil, error)
                print("error upload image")
            }
        }
        
        task.resume()
    }
    
    
    func fetchGeolocation(base64ImageString: String, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        let headers = [
            "Authorization": "Bearer \(Constants.geoSpyApiKey)",
            "Content-Type": "application/json"
        ]
        
        let parameters = [
            "top_k": 1,
            "image": base64ImageString,
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON data"])))
            return
        }
        
        var request = URLRequest(url: URL(string: "\(Constants.geoSpyPredictApi)")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get successful response"])))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data in response"])))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                if let geoPredictions = json?["geo_predictions"] as? [[String: Any]], let firstPrediction = geoPredictions.first,
                   let coordinates = firstPrediction["coordinates"] as? [Double],
                   let latitude = coordinates.first,
                   let longitude = coordinates.last,
                   let address = firstPrediction["address"] as? String {
                    let locationModel = LocationModel(latitude: latitude, longitude: longitude, address: address)
                    completion(.success(locationModel))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
