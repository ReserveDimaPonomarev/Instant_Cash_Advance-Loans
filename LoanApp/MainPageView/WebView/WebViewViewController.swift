//
//  WebViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 07.12.2023.
//


import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let webView = WKWebView()
    
    //  MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        view.addSubview(webView)
        guard let url = URL(string: "https://loan-instant-cash-advance.online/") else { return }
        webView.load(URLRequest(url: url))
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
