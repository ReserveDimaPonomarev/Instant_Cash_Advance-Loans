//
//  FirstViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
           
    //  MARK: External dependencies

    var loginOutput: LoginOutput?
    
    //MARK: - UI properties

    private let backgroundImageView = CustomBackgroundImageView()
    private let contentView = UIView()
    private let topLabelStackView = UIStackView()
    private let easyAndQuicklabel = UILabel()
    private let approvalLabel = UILabel()
    private let manImageView = UIImageView()
    private let bottomView = CustomBottomView()
  
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

private extension FirstViewController {
    
    //MARK: - addViews
    
    func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(topLabelStackView)
        topLabelStackView.addArrangedSubview(easyAndQuicklabel)
        topLabelStackView.addArrangedSubview(approvalLabel)
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
            make.top.equalTo(topLabelStackView.snp.bottom).offset(10)
            make.centerX.equalTo(self.view.snp.left).offset(70)
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
        navigationItem.hidesBackButton = true
        topLabelStackView.makeCustomStackView(alignment: .leading)
        easyAndQuicklabel.makespecifiedLabelInStack(text: "Easy and Quick")
        approvalLabel.makespecifiedLabelInStack(text: "Approval")
        
        bottomView.setupCurrentPageNumber(.first)
        
        manImageView.image = UIImage(resource: .man1)
        manImageView.contentMode = .scaleAspectFit
    }
    
    //MARK: - setupActions
    
    func setupActions() {
        bottomView.nextPageButton.addTarget(self, action: #selector(onNextPageButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - objc method

    @objc func onNextPageButtonTapped() {
        loginOutput?.showSecondScreen()
    }
}
