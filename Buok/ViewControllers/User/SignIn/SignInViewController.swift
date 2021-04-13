//
//  SignInViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/17.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

public class SignInViewController: HeroBaseViewController {
    let guideLabel = UILabel()
    let emailField = UITextField()
    let nextButton = UIButton()
    let orLabel = UILabel()
    let appleSignInButton = UIButton()
    let googleSignInButton = UIButton()
    let kakaoSignInButton = UIButton()
    let servicePolicyButton = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
    }
}
