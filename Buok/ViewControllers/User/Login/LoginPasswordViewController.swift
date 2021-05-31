//
//  EnterPasswordViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/13.
//  Modified by Taein Kim on 2021/05/31.
//

import HeroUI

class LoginPasswordViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let passwordField = UserTextField()
    let eyeButton = UIButton()
    let wrongPasswordLabel = UILabel()
    let forgetButton = UIButton()
    let loginButton = LoginButton()
    
    weak var viewModel: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.isLoginSuccess.bind({ [weak self] isSuccess in
            if isSuccess {
                self?.wrongPasswordLabel.isHidden = true
                // Go To Home
                self?.viewModel?.setRootVCToHomeVC()
            } else {
                self?.wrongPasswordLabel.isHidden = false
            }
        })
        
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
        viewModel?.password = passwordField.text ?? ""
        viewModel?.requestLogin()
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
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
