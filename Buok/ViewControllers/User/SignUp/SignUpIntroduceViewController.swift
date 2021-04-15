//
//  SignUpIntroduceViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

class SignUpIntroduceViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let enterField = IntroduceTextField()
    let countLabel = UILabel()
    let finishButton = SignServiceButton()
    let passButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupGuideLabel()
        setupEnterField()
        setupCountLabel()
        setupFinishButton()
        setupPassButton()
    }

    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
