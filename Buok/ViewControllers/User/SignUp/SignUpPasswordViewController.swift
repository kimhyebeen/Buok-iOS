//
//  SignUpViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

public class SignUpPasswordViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let passwordField = PasswordTextField()
    let nextButton = SignServiceButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupGuideLabel()
        setupPasswordField()
        setupNextButton()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
