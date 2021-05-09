//
//  ResetPasswordViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/09.
//

import HeroUI

class ResetPasswordViewController: HeroBaseViewController {
    let backButton = UIButton()
    let closeButton = UIButton()
    let guideLabel = UILabel()
    let passwordField = UserTextField()
    let eyeButton = UIButton()
    let finishButton = UserServiceButton()
    
    weak var viewModel: ForgetViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupCloseButton()
        setupGuideLabel()
        setupPasswordField()
        setupEyeButton()
        setupFinishButton()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func clickEyeButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.isSelectedEyeButton = !viewmodel.isSelectedEyeButton
        passwordField.isSecureTextEntry = !viewmodel.isSelectedEyeButton
        sender.isSelected = viewmodel.isSelectedEyeButton
    }
    
    @objc
    func clickFinishButton(_ sender: UIButton) {
        // todo - 비밀번호 재설정 요청
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let viewmodel = viewModel else { return }
        finishButton.setHeroEnable(viewmodel.validatePassword(textField.text ?? ""))
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension ResetPasswordViewController {
    // MARK: BackButton
    func setupBackButton() {
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(3)
        }
    }
    
    // MARK: CloseButton
    func setupCloseButton() {
        closeButton.setImage(UIImage(heroSharedNamed: "ic_x"), for: .normal)
        closeButton.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-4)
        }
    }
    
    // MARK: GuideLabel
    func setupGuideLabel() {
        guideLabel.font = .font22P
        guideLabel.textColor = .heroGray5B
        guideLabel.text = "비밀번호를 재설정해주세요."
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(22)
        }
    }
    
    // MARK: PasswordField
    func setupPasswordField() {
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        passwordField.setPlaceHolder("6글자 이상")
        self.view.addSubview(passwordField)
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(192)
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
    
    // MARK: FinishButton
    func setupFinishButton() {
        finishButton.setHeroEnable(false)
        finishButton.setHeroTitle("완료")
        finishButton.addTarget(self, action: #selector(clickFinishButton(_:)), for: .touchUpInside)
        self.view.addSubview(finishButton)
        
        finishButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
