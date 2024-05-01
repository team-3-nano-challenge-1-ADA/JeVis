//
//  GifView.swift
//  JeVis
//
//  Created by Jovanna Melissa on 01/05/24.
//

import SwiftUI
import WebKit
import UIKit

struct GifView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String){
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
//        let image = UIImage(named: name)
//        let url = image?.url
//        let data = try! Data(contentsOf: url!)
//        webView.load(data,
//                     mimeType: "image/gif",
//                     characterEncodingName: "UTF-8",
//                     baseURL: url!.deletingLastPathComponent()
//        )
        
        if let image = UIImage(named: name) {
                    image.accessibilityIdentifier = name // Setting accessibility identifier
                    if let url = image.url {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else {
                                // Handle error
                                return
                            }
                            DispatchQueue.main.async {
                                webView.load(data,
                                             mimeType: "image/gif",
                                             characterEncodingName: "UTF-8",
                                             baseURL: url.deletingLastPathComponent()
                                )
                            }
                        }.resume()
                    }
                }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
        //untuk reload content kalau ada update
    }
    
//    typealias UIViewType = WKWebView
}

extension UIImage {
    var url: URL? {
        if let assetName = self.accessibilityIdentifier {
            let bundle = Bundle(for: type(of: self))
            return bundle.url(forResource: assetName, withExtension: "gif")
        }
        return nil
    }
}

#Preview {
    GifView("loadingGif")
}
