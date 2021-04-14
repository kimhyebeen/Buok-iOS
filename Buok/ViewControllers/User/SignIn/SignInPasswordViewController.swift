//
//  EnterPasswordViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/13.
//

import HeroUI

class SignInPasswordViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let passwordField = PasswordTextField()
    let forgotPasswordButton = UIButton()
    let signInButton = SignServiceButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .heroServiceSkin
        
        setupBackButton()
        setupGuideLabel()
        setupPasswordField()
        setupForgotPasswordButton()
        setupSignInButton()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
