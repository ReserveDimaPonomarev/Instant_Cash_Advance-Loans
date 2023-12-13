//
//  FourthScreenViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

final class HowItWorksViewController: UIViewController {

    //  MARK: - UI properties
    
    let questionLabel = UILabel()
    let topTitlelabel = UILabel()
    let topSubtitleLabel = UILabel()
    let stackView = UIStackView()
    let firstBlueView = BlueViewForHowITWorks()
    let secondBlueView = BlueViewForHowITWorks()
    let thirdBlueView = BlueViewForHowITWorks()
    
    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
    }
}

//  MARK: - private methods

private extension HowItWorksViewController {
    
    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    func addViews() {
        view.addSubview(questionLabel)
        view.addSubview(topTitlelabel)
        view.addSubview(topSubtitleLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstBlueView)
        stackView.addArrangedSubview(secondBlueView)
        stackView.addArrangedSubview(thirdBlueView)
    }
    
    func setupViews() {
        questionLabel.text = "?"
        questionLabel.textColor = .blue
        questionLabel.font = .systemFont(ofSize: 60, weight: .black)
        topTitlelabel.text = "How It Works"
        topTitlelabel.textColor = .blue
        topTitlelabel.font = .systemFont(ofSize: 30, weight: .black)

        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        
        topSubtitleLabel.text = "The process is super fast and simple.\nIt takes minutes to see results and enjoy your extra cash"
        topSubtitleLabel.textColor = .blue
        topSubtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        topSubtitleLabel.numberOfLines = 0
        firstBlueView.setupTextInsideView(number: 1, title: "Submit A Request", subtitle: "Submit A Request \nAll paperwork is gone! The whole process is completely online. Just fill in a few details about yourself and hit \"Get Started\"!")
        secondBlueView.setupTextInsideView(number: 2, title: "Check The Offers", subtitle: "If the offer suits your needs and desires, and you agree with all the terms - simply e-sign the deal and get ready to enjoy the money!")
        thirdBlueView.setupTextInsideView(number: 3, title: "Receive Your Money", subtitle: "Once you submit your request, get your offer, and e-sign it, you'll be able to get the funds to your bank account in no time!")
    }
        
    func setupConstraints() {
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        topTitlelabel.snp.makeConstraints { make in
            make.leading.equalTo(questionLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(questionLabel).inset(5)
        }
        topSubtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(topTitlelabel)
            make.top.equalTo(topTitlelabel.snp.bottom).offset(8)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(topSubtitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
        
    //  MARK: - private methods

    
    //  MARK: - objc method
    
}
