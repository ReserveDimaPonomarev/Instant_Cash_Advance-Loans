//
//  LoadingPageViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 05.12.2023.
//

import UIKit
import FBSDKCoreKit
import AppsFlyerLib

protocol LoadingPageDisplayLogic: AnyObject {
    
}

final class LoadingPageViewController: UIViewController, LoadingPageDisplayLogic {
    
    //  MARK: External dependencies
    
    var presenter: LoadingPagePresenterProtocol
    
    //  MARK: - UI properties
    
    private let imageView = UIImageView()
    private let progressView = UIProgressView()
    private var timerToDownloadProgressView: Timer?
    
    //  MARK: - init
    
    init(presenter: LoadingPagePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LoadingPageViewController deinited")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        AppEvents.logEvent(.viewedContent)
    }
}

//  MARK: - private methods

private extension LoadingPageViewController {
    
    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        setupConstraints()
        
        checkAppsFlyer()
    }
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(progressView)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        imageView.image = .loading
        imageView.contentMode = .scaleAspectFit
        setupProgressView()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(imageView.snp.width)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.right.equalTo(imageView)
        }
    }
    
    func setupProgressView() {
        timerToDownloadProgressView = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self else { return }
            self.progressView.progress += 0.01 / 3.0
            if self.progressView.progress >= 1.0 {
                self.progressCompleted()
            }
        }
    }
    
    //  MARK: - private methods
    
    func progressCompleted() {
        self.timerToDownloadProgressView?.invalidate()
        presenter.progressHasBeenCompleted()
    }
    
    func checkAppsFlyer() {
        AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
            if (error != nil){
                self.checkUserTap()
                return
            } else {
                print(dictionary ?? "")
                return
            }
        })
    }
    
    func checkUserTap() {
        let url = URL(string: "https://app.appsflyer.com/id6473890001?pid=conversionTest1&idfa=B3ED101D-96FB-4E60-BEBD-00AC506C1CD2")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            print(response)

            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                print(json)
            }
        }.resume()
    }
    
    
    
    //  MARK: - objc method
    
}
