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
    private var networkCheck = NetworkCheck.sharedInstance()

    
    //  MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        checkConnectionStatus()
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
//    MARK: - Check InternetConnection
    
    private func checkConnectionStatus() {
        if networkCheck.currentStatus == .satisfied{
            loadWebView()
        }else{
            showAlert()
        }
        networkCheck.addObserver(observer: self)
    }
    
    private func loadWebView() {
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        guard let url = URL(string: "https://loan-instant-cash-advance.online/") else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension WebViewViewController: NetworkCheckObserver {
    
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            loadWebView()
        } else if status == .unsatisfied {
            showAlert()
        }
    }
}
