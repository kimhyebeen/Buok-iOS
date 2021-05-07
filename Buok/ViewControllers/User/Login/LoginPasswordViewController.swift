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
    let forgotPasswordButton = UIButton()
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
        setupForgotPasswordButton()
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
        // todo - 로그인 요청 성공 시 메인 화면으로 넘기기
        // todo - 로그인 요청 실패 시 실패라벨 처리
    }
}

extension LoginPasswordViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        loginButton.setHeroEnable(viewModel?.validatePassword(textField.text ?? "") ?? false)
    }
}
