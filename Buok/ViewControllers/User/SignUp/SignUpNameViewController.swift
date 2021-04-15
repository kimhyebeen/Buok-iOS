//
//  SignUpNameViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

class SignUpNameViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let nameField = SignTextField()
    let subGuideLabel = UILabel()
    let countLabel = UILabel()
    let nextButton = SignServiceButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupGuideLabel()
        setupNameField()
        setupSubGuideLabel()
        setupCountLabel()
        setupNextButton()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
