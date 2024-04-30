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
    @Binding var isLoading: Bool
    
    func makeViewConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        let dropSharedWorkersScript = WKUserScript(source: "delete window.SharedWorker;", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(dropSharedWorkersScript)
        return configuration
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 400), configuration: makeViewConfiguration())
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            webView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }
    }
}
