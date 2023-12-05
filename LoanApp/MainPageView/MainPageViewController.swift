//
//  MainPageViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import UIKit

final class MainPageViewController: UIViewController {
    
    //  MARK: - UI properties
    private let backgroundImage = UIImageView()
    private let fiveLabel = CustomTitleLabel()
    private let minLabel = CustomTitleLabel()
    private let formLabel = CustomTitleLabel()
    private let toLabel = CustomTitleLabel()
    private let recieveMoneyLabel = CustomTitleLabel()
    private let manImageView = UIImageView()
    private let getALoanButton = CustomButton()
    private let inputtedLabel = CustomTitleLabel()
    private let inputtedImageView = UIImageView()
    private let openMenuButton = UIButton()
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        view.addSubview(backgroundImage)
        view.addSubview(fiveLabel)
        view.addSubview(minLabel)
        view.addSubview(formLabel)
        view.addSubview(toLabel)
        view.addSubview(recieveMoneyLabel)
        view.addSubview(manImageView)
        view.addSubview(getALoanButton)
        view.addSubview(inputtedLabel)
        view.addSubview(inputtedImageView)
        view.addSubview(openMenuButton)
        
        
    }
    
    private func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        
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
        
        inputtedImageView.image = .protection
        inputtedImageView.contentMode = .scaleAspectFit
        inputtedLabel.setupCustomLabelOnMainScreen(text: "Protected by encryption", fontSize: 18, allignment: .center)
        inputtedLabel.minimumScaleFactor = 0.1
        inputtedLabel.adjustsFontForContentSizeCategory = true
        manImageView.image = .man4
        manImageView.contentMode = .scaleAspectFit
        
        openMenuButton.setImage(.openMenu, for: .normal)
        openMenuButton.addTarget(self, action: #selector(onShowMenuTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        openMenuButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(50)
        }
        fiveLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
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
        inputtedLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(inputtedLabel.intrinsicContentSize.height / 2)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        inputtedImageView.snp.makeConstraints { make in
            make.right.equalTo(inputtedLabel.snp.left).offset(-5)
            make.top.equalTo(inputtedLabel)
            make.height.equalTo(inputtedLabel.intrinsicContentSize.height)
            make.width.equalTo(inputtedImageView.snp.height)
        }
        getALoanButton.snp.makeConstraints { make in
            make.bottom.equalTo(inputtedLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(30)
        }
        manImageView.snp.makeConstraints { make in
            make.top.equalTo(recieveMoneyLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(getALoanButton.snp.top)
        }
    }
    
    //  MARK: - objc method
    
    @objc func onShowMenuTapped() {
        
        let halfScreenViewController = CustomHalfView()
        let screenBounds = UIScreen.main.bounds
        halfScreenViewController.view.frame = CGRect(x: screenBounds.width, y: 0, width: screenBounds.width / 3 * 2, height: screenBounds.height)

        addChild(halfScreenViewController)
        view.addSubview(halfScreenViewController.view)
        halfScreenViewController.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.3) {
            halfScreenViewController.view.frame.origin.x = UIScreen.main.bounds.width / 3
        }
    }
}
