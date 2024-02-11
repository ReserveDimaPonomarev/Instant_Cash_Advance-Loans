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
    
    private func getData(_ type: DeepLinkType) -> String {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        var strData: String? = ""
        let v = appDelegate?.ConversionData
        print(v)
        if let data = appDelegate?.ConversionData {
            switch type {
            case .value:
                strData = data["deep_link_value"] as? String
            case .sub1:
                strData = data["deep_link_sub1"] as? String
            case .sub2:
                strData = data["deep_link_sub2"] as? String
            case .sub3:
                strData = data["deep_link_sub3"] as? String
            }
        }
        return strData != nil ? strData! :  ""
    }
    
    private func loadWebView() {
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        guard let url = URL(string: "https://loan-instant-cash-advance.online/?sub_id_1=942&deep_link_value=\(getData(.value))&deep_link_sub1=\(getData(.sub1))&deep_link_sub2=\(getData(.sub2))&deep_link_sub3=\(getData(.sub3))") else { return }
        print(url)
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

enum DeepLinkType {
    case value
    case sub1
    case sub2
    case sub3
}
