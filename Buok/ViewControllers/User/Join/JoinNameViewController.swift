//
//  SignUpNameViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

class JoinNameViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let nameField = UserTextField()
    let subGuideLabel = UILabel()
    let countLabel = UILabel()
    let nextButton = LoginButton()
	var isSNSLogin: Bool = false
    
    weak var viewModel: UserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.isNicknameExist.bind({ [weak self] isExist in
            guard let isExist = isExist else {
                // todo - 그냥 오류
                return
            }
            
            if isExist {
                self?.subGuideLabel.text = "중복된 별칭입니다"
                self?.subGuideLabel.textColor = .heroServiceSubPink
            } else {
                let introduceVC = JoinIntroduceViewController()
                introduceVC.viewModel = self?.viewModel
				if self?.isSNSLogin == true {
					introduceVC.isSNSLogin = true
				}
                self?.navigationController?.pushViewController(introduceVC, animated: true)
            }
        })
        
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
    
    @objc
    func clickNextButton(_ sender: UIButton) {
        if let nickname = nameField.text {
            viewModel?.checkNicknameExist(nickname)
        }
    }
}

// MARK: Delegate
extension JoinNameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let viewmodel = viewModel else { return }
        guard let text = textField.text else { return }
        guard let count = textField.text?.count else { return }
//        textField.text = text.trimmingCharacters(in: .whitespaces)
        nextButton.setHeroEnable(viewmodel.validateNickName(textField.text ?? ""))
        countLabel.text = "\(count)/12"
    }
}

extension JoinNameViewController {
    // MARK: Back Button
    func setupBackButton() {
        // todo - 뒤로가기 아이콘 적용
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(3)
        }
    }
    
    // MARK: Guide Label
    func setupGuideLabel() {
        guideLabel.numberOfLines = 0
        guideLabel.attributedText = NSAttributedString(string: "당신의 정체성을 담은\n별칭을 적어보세요.", attributes: [.font: UIFont.font22P, .foregroundColor: UIColor.heroGray5B])
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: Name Field
    func setupNameField() {
        nameField.delegate = self
        nameField.setPlaceHolder("별칭을 입력해주세요")
        self.view.addSubview(nameField)
        
        nameField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: Sub Guide Label
    func setupSubGuideLabel() {
        subGuideLabel.text = "한글/영문/숫자만 사용 가능합니다."
        subGuideLabel.font = .font13P
        subGuideLabel.textColor = .heroGrayA6A4A1
        self.view.addSubview(subGuideLabel)
        
        subGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(22)
        }
    }
    
    // MARK: Count Label
    func setupCountLabel() {
        countLabel.text = "0/12"
        countLabel.font = .font13P
        countLabel.textColor = .heroGrayA6A4A1
        self.view.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
    
    // MARK: Next Button
    func setupNextButton() {
        nextButton.setHeroTitle("계속하기")
        nextButton.loginButtonType = .none
        nextButton.setHeroEnable(false)
        nextButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(nameField.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
}
