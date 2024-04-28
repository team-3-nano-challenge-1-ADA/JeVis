//
//  WebView.swift
//  JeVis
//
//  Created by Rizki Maulana on 28/04/24.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Handle potential URL updates here
    }
}
