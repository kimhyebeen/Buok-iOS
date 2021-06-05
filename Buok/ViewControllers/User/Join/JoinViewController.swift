//
//  SignUpViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

public class JoinViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let passwordField = UserTextField()
    let eyeButton = UIButton()
    let nextButton = LoginButton()
    
    weak var viewModel: UserViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupGuideLabel()
        setupPasswordField()
        setupEyeButton()
        setupNextButton()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickEyeButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.isSelectedEyeButton = !viewmodel.isSelectedEyeButton
        sender.isSelected = viewmodel.isSelectedEyeButton
        passwordField.isSecureTextEntry = !eyeButton.isSelected
    }
    
    @objc
    func clickNextButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.password = passwordField.text!
        
        let nameVC = JoinNameViewController()
        nameVC.viewModel = viewModel
        self.navigationController?.pushViewController(nameVC, animated: true)
    }
}

// MARK: Delegate
extension JoinViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let viewmodel = viewModel else { return }
        nextButton.setHeroEnable(viewmodel.validatePassword(textField.text ?? ""))
    }
}

extension JoinViewController {
    // MARK: BackButton
    func setupBackButton() {
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(3)
        }
    }
    
    // MARK: GuideLabel
    func setupGuideLabel() {
        guideLabel.font = .font22P
        guideLabel.numberOfLines = 0
        guideLabel.textColor = .heroGray5B
        guideLabel.text = "buok에 오신 것을 환영합니다.\n비밀번호를 설정해주세요."
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: PasswordField
    func setupPasswordField() {
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        passwordField.setPlaceHolder("6글자 이상")
        self.view.addSubview(passwordField)
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: EyeButton
    func setupEyeButton() {
        if #available(iOS 13.0, *) {
            eyeButton.setImage(UIImage(heroSharedNamed: "ic_eye")!.withTintColor(.heroGrayA6A4A1), for: .normal)
            eyeButton.setImage(UIImage(heroSharedNamed: "ic_eye_fill")!.withTintColor(.heroGray5B), for: .selected)
        } else {
            eyeButton.setImage(UIImage(heroSharedNamed: "ic_eye")!, for: .normal)
            eyeButton.setImage(UIImage(heroSharedNamed: "ic_eye_fill")!, for: .selected)
        }
        eyeButton.addTarget(self, action: #selector(clickEyeButton(_:)), for: .touchUpInside)
        self.view.addSubview(eyeButton)
        
        eyeButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.centerY.equalTo(passwordField.snp.centerY)
            make.trailing.equalTo(passwordField.snp.trailing).offset(-4)
        }
    }
    
    // MARK: NextButton
    func setupNextButton() {
        nextButton.loginButtonType = .none
        nextButton.setHeroTitle("계속하기")
        nextButton.setHeroEnable(false)
        nextButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
