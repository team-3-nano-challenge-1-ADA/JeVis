//
//  GifView.swift
//  JeVis
//
//  Created by Jovanna Melissa on 01/05/24.
//

import SwiftUI
import WebKit

struct GifView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String){
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
//        webView.load(data,
//                     mimeType: "image/gif",
//                     characterEncodingName: "UTF-8",
//                     baseURL: url.deletingLastPathComponent()
//        )
        
        let html = """
                <html>
                <head>
                    <style>
                        body {
                            background-color: #CAE9FF; /* Custom background color */
                            color: black; /* Text color */
                        }
                    </style>
                </head>
                <body>
                    <img src="loadingGif2.gif" alt="GIF" width=950 alignment=center>
                </body>
                </html>
                """

                webView.loadHTMLString(html, baseURL: url.deletingLastPathComponent())
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
        //untuk reload content kalau ada update
    }
    
//    typealias UIViewType = WKWebView
}

#Preview {
    GifView("loadingGif")
}
