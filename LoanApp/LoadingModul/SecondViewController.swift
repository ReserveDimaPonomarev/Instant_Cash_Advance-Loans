//
//  SecondViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import UIKit
import SnapKit
import AppsFlyerLib

class SecondViewController: UIViewController {
            
    //  MARK: External dependencies

    var loginOutput: LoginOutput?
    
    //MARK: - UI properties

    let backgroundImageView = CustomBackgroundImageView()
    let topLabelStackView = UIStackView()
    let loansUpTolabel = UILabel()
    let thousandsLabel = UILabel()
    let manImageView = UIImageView()
    let bottomView = CustomBottomView()
    
    //MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        setupViews()
        makeConstraints()
        setupActions()
    }
}

//  MARK: - private methods

private extension SecondViewController {
    
    //MARK: - addViews
    
    func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(topLabelStackView)
        topLabelStackView.addArrangedSubview(loansUpTolabel)
        topLabelStackView.addArrangedSubview(thousandsLabel)
        view.addSubview(manImageView)
        view.addSubview(bottomView)
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        manImageView.snp.makeConstraints { make in
            make.top.equalTo(loansUpTolabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).offset(40)
        }
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.left.right.equalToSuperview()
        }
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        view.backgroundColor = .blue

        topLabelStackView.makeCustomStackView(alignment: .leading)
        loansUpTolabel.makespecifiedLabelInStack(text: "Loans up to")
        thousandsLabel.makespecifiedLabelInStack(text: "5000$")
        
        bottomView.setupCurrentPageNumber(.second)
        
        manImageView.image = UIImage(resource: .man2)
        manImageView.contentMode = .scaleAspectFit
    }
    
    //MARK: - setupActions
    
    func setupActions() {
        bottomView.nextPageButton.addTarget(self, action: #selector(onNextPageButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - objc method

    @objc func onNextPageButtonTapped() {
        loginOutput?.showThirdScreen()
    }
}
