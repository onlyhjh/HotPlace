//
//  HotWebView.swift
//  HotPlace
//
//  Created by 60192229 on 8/6/24.
//

import SwiftUI
import WebKit

struct HotWebView: UIViewRepresentable {
    var urlStr: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let reqURL = URL(string: urlStr) else {
            Logger.log("not found request URL")
            return WKWebView.init(frame: .zero)
        }
        let webView = WKWebView()
        let req = URLRequest(url: reqURL)
        webView.load(req)
       
        return webView
    }
    
    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<HotWebView>) {
        Logger.log("")
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator {
        var parent: HotWebView
        
        deinit {
            Logger.log("")
        }
        
        init(_ parent: HotWebView) {
            Logger.log("")
            self.parent = parent
        }
        
        // MARK: - SSL 우회코드

        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            Logger.log("")
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                return completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
            }
            return completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
        }
    }
}

#Preview {
    HotWebView(urlStr: "https://naver.com")
}
