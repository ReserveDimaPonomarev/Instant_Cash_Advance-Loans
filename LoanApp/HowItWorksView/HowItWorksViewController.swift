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
    let blueView = BlueViewForHowITWorks()
    let secondBlueView = BlueViewForHowITWorks()
    let thirdBlueView = BlueViewForHowITWorks()


    
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
        view.addSubview(questionLabel)
        view.addSubview(topTitlelabel)
        view.addSubview(topSubtitleLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(blueView)
        stackView.addArrangedSubview(secondBlueView)
        stackView.addArrangedSubview(thirdBlueView)

    }
    
    private func setupViews() {
        questionLabel.text = "?"
        questionLabel.textColor = .blue
        questionLabel.font = .systemFont(ofSize: 60, weight: .black)
        topTitlelabel.text = "How It Works"
        topTitlelabel.textColor = .blue
        topTitlelabel.font = .systemFont(ofSize: 30, weight: .black)

        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        
        topSubtitleLabel.text = "blablablablablablablablablablablablablablablablablablablablablablablablablablablabla"
        topSubtitleLabel.textColor = .blue
        topSubtitleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        topSubtitleLabel.numberOfLines = 0




    }
        
    private func setupConstraints() {
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)

        }
        topTitlelabel.snp.makeConstraints { make in
            make.leading.equalTo(questionLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(questionLabel)
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
