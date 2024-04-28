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
}
