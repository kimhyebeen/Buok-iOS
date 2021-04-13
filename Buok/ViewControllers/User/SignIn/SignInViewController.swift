//
//  SignInViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/13.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

public class SignInViewController: HeroBaseViewController {
    let scrollView = UIScrollView()
    let contentsView = UIView()
    
    let guideLabel = UILabel()
    let emailField = SignTextField()
    let nextButton = SignServiceButton()
    let orLabel = UILabel()
    let appleSignInButton = SignServiceButton()
    let googleSignInButton = SignServiceButton()
    let kakaoSignInButton = SignServiceButton()
    let servicePolicyButton = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .heroServiceSkin
        
        setupScrollView()
        setupGuideLabel()
        setupEmailField()
        setupNextButton()
        setupOrLabel()
        setupAppleSignInButton()
        setupGoogleSignInButton()
        setupKakaoSignInButton()
        setupServicePolicyButton()
    }
}
