//
//  MainPageViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import UIKit
import FBSDKCoreKit

protocol MainPageDisplayLogic: AnyObject {
    
}

final class MainPageViewController: UIViewController, MainPageDisplayLogic {
    
    //  MARK: External dependencies
    
    var presenter: MainPagePresenterProtocol
    
    //  MARK: - UI properties
    
    private let backgroundImage = UIImageView()
    private let signInButton = CustomSignInView()
    private let signOutButton = CustomSignInView()
    private let fiveLabel = CustomTitleLabel()
    private let minLabel = CustomTitleLabel()
    private let formLabel = CustomTitleLabel()
    private let toLabel = CustomTitleLabel()
    private let recieveMoneyLabel = CustomTitleLabel()
    private let manImageView = UIImageView()
    private let getALoanButton = CustomButton()
    private let protectDescriptionLabel = CustomTitleLabel()
    private let protectDescriptionImageView = UIImageView()
    private let openHalfMenuButton = UIButton()

    //  MARK: - init
    
    init(presenter: MainPagePresenterProtocol) {
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
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signOutButton.isHidden = !presenter.isUserAuthorized()
        signInButton.isHidden = presenter.isUserAuthorized()
    }
}

//  MARK: - private methods

private extension MainPageViewController {
    
    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        setupConstraints()
        addActions()
    }
    
    func addViews() {
        view.addSubview(backgroundImage)
        view.addSubview(signInButton)
        view.addSubview(signOutButton)
        view.addSubview(fiveLabel)
        view.addSubview(minLabel)
        view.addSubview(formLabel)
        view.addSubview(toLabel)
        view.addSubview(recieveMoneyLabel)
        view.addSubview(manImageView)
        view.addSubview(getALoanButton)
        view.addSubview(protectDescriptionLabel)
        view.addSubview(protectDescriptionImageView)
        view.addSubview(openHalfMenuButton)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        backgroundImage.image = UIImage(resource: .background)
        signInButton.setTitle("Sign In")
        signInButton.isHidden = presenter.isUserAuthorized()
        signOutButton.setTitle("Sign Out")
        signOutButton.isHidden = !presenter.isUserAuthorized()

        fiveLabel.setupCustomLabelOnMainScreen(text: "5", fontSize: 80, allignment: .natural)
        minLabel.setupCustomLabelOnMainScreen(text: "min", fontSize: 45, allignment: .natural)
        minLabel.minimumScaleFactor = 0.5
        minLabel.adjustsFontForContentSizeCategory = true
        formLabel.setupCustomLabelOnMainScreen(text: "form", fontSize: 35, allignment: .natural)
        formLabel.minimumScaleFactor = 0.9
        formLabel.adjustsFontForContentSizeCategory = true
        recieveMoneyLabel.setupCustomLabelOnMainScreen(text: "Receive\nMoney", fontSize: 35, allignment: .natural)
        recieveMoneyLabel.numberOfLines = 0
        toLabel.setupCustomLabelOnMainScreen(text: "to", fontSize: 35, allignment: .natural)
        toLabel.textAlignment = .center
        
        getALoanButton.setupButtonForMainView(title: "Get A Loan", color: .blue, titleColor: .white)
        
        protectDescriptionImageView.image = .protection
        protectDescriptionImageView.contentMode = .scaleAspectFit
        protectDescriptionLabel.setupCustomLabelOnMainScreen(text: "Protected by encryption", fontSize: 18, allignment: .center)
        protectDescriptionLabel.minimumScaleFactor = 0.1
        protectDescriptionLabel.adjustsFontForContentSizeCategory = true
        manImageView.image = .man4
        manImageView.contentMode = .scaleAspectFit
        
        openHalfMenuButton.setImage(.openMenu, for: .normal)
    }
    
    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        openHalfMenuButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(50)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
        }
        signOutButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton)
            make.left.equalTo(signInButton)
        }
        fiveLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        minLabel.snp.makeConstraints { make in
            make.top.equalTo(fiveLabel)
            make.left.equalTo(fiveLabel.snp.right).offset(3)
        }
        formLabel.snp.makeConstraints { make in
            make.top.equalTo(minLabel.snp.bottom).inset(10)
            make.left.equalTo(fiveLabel.snp.right).offset(3)
        }
        recieveMoneyLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(fiveLabel.snp.bottom).inset(20)
        }
        toLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(formLabel).inset(10)
        }
        protectDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(protectDescriptionLabel.intrinsicContentSize.height / 2)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        protectDescriptionImageView.snp.makeConstraints { make in
            make.right.equalTo(protectDescriptionLabel.snp.left).offset(-5)
            make.top.equalTo(protectDescriptionLabel)
            make.height.equalTo(protectDescriptionLabel.intrinsicContentSize.height)
            make.width.equalTo(protectDescriptionImageView.snp.height)
        }
        getALoanButton.snp.makeConstraints { make in
            make.bottom.equalTo(protectDescriptionLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(30)
        }
        manImageView.snp.makeConstraints { make in
            make.top.equalTo(recieveMoneyLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(getALoanButton.snp.top).offset(40)
        }
    }
    
    func showAlertToSignOut() {
        let alertController = UIAlertController(title: "Are you sure to sign out?", message: nil, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.presenter.userSignOut()
            self.signOutButton.isHidden = !self.presenter.isUserAuthorized()
            self.signInButton.isHidden = self.presenter.isUserAuthorized()
        }
        let actionNo = UIAlertAction(title: "No", style: .default)
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)

        present(alertController, animated: true)
    }
    
    //  MARK: - addActions

    func addActions() {
        let gestureRecognizerSignIn = UITapGestureRecognizer(target: self, action: #selector(onSignInButtonTap))
        signInButton.addGestureRecognizer(gestureRecognizerSignIn)
        let gestureRecognizerSignOut = UITapGestureRecognizer(target: self, action: #selector(onSignOutButtonTap))
        signOutButton.addGestureRecognizer(gestureRecognizerSignOut)
        getALoanButton.addTarget(self, action: #selector(onGetALoanButtonTap), for: .touchUpInside)
        openHalfMenuButton.addTarget(self, action: #selector(onShowMenuTapped), for: .touchUpInside)
    }
    
    //  MARK: - objc method
    
    @objc func onShowMenuTapped() {
        let halfScreenViewController = HalfViewController()
        let screenBounds = UIScreen.main.bounds
        halfScreenViewController.view.frame = CGRect(x: screenBounds.width, y: 0, width: screenBounds.width / 3 * 2, height: screenBounds.height)

        addChild(halfScreenViewController)
        view.addSubview(halfScreenViewController.view)
        halfScreenViewController.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.3) {
            halfScreenViewController.view.frame.origin.x = UIScreen.main.bounds.width / 3
        }
    }
    
    @objc func onGetALoanButtonTap() {
        presenter.showWebViewOnMainPage()
    }
    
    @objc func onSignInButtonTap() {
        presenter.userSignedIn()
        signOutButton.isHidden = !presenter.isUserAuthorized()
        signInButton.isHidden = presenter.isUserAuthorized()
    }
    
    @objc func onSignOutButtonTap() {
        showAlertToSignOut()
    }
}
