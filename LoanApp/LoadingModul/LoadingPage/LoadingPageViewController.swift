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
    
    //  MARK: - objc method
    
}
