//
//  EnterPasswordViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/13.
//

import HeroUI

class LoginPasswordViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let passwordField = UserTextField()
    let eyeButton = UIButton()
    let wrongPasswordLabel = UILabel()
    let forgetButton = UIButton()
    let loginButton = UserServiceButton()
    
    weak var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupGuideLabel()
        setupPasswordField()
        setupEyeButton()
        setupWrongPasswordLabel()
        setupForgetButton()
        setupLoginButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickEyeButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.isSelectedEyeButton = !viewmodel.isSelectedEyeButton
        passwordField.isSecureTextEntry = !viewmodel.isSelectedEyeButton
        sender.isSelected = viewmodel.isSelectedEyeButton
    }
    
    @objc
    func clickLoginButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.password = passwordField.text ?? ""
        // todo - 로그인 요청 성공 시 메인 화면으로 넘기기
        // todo - 로그인 요청 실패 시 실패라벨 처리
        guard let token = viewmodel.requestLogin() else {
            wrongPasswordLabel.isHidden = false
            return
        }
        wrongPasswordLabel.isHidden = true
        // todo - token 저장
        // todo - main 화면 이동
    }
    
    @objc
    func clickforgetButton(_ sender: UIButton) {
        let navigationVC = UINavigationController(rootViewController: ForgetViewController())
        navigationVC.modalPresentationStyle = .fullScreen
        navigationVC.isNavigationBarHidden = true
        self.show(navigationVC, sender: nil)
    }
}

extension LoginPasswordViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        loginButton.setHeroEnable(viewModel?.validatePassword(textField.text ?? "") ?? false)
    }
}
