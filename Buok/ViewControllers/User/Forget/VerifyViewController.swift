//
//  VerifyViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/09.
//

import HeroUI

class VerifyViewController: HeroBaseViewController {
    let backButton = UIButton()
    let closeButton = UIButton()
    let guideLabel = UILabel()
    let verifyField = UserTextField()
    let wrongLabel = UILabel()
    let nextButton = LoginButton()
    
    weak var viewModel: ForgetViewModel?
    var nextButtonTopAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupCloseButton()
        setupGuideLabel()
        setupVerifyField()
        setupWrongLabel()
        setupNextButton()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func clickNextButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        if viewmodel.requestVerifyCode(verifyField.text!) {
            let resetVC = ResetPasswordViewController()
            resetVC.viewModel = viewModel
            self.navigationController?.pushViewController(resetVC, animated: true)
        } else { activeWrongLabel() }
    }
    
    private func activeWrongLabel() {
        wrongLabel.isHidden = false
        DispatchQueue.main.async { [weak self] in
            self?.nextButtonTopAnchor?.constant = 50
        }
    }
    
}

// MARK: Delegate
extension VerifyViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard viewModel != nil else { return }
        nextButton.setHeroEnable(!(textField.text?.isEmpty ?? true))
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension VerifyViewController {
    // MARK: BackButton
    func setupBackButton() {
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(3)
        }
    }
    
    // MARK: CloseButton
    func setupCloseButton() {
        closeButton.setImage(UIImage(heroSharedNamed: "ic_x"), for: .normal)
        closeButton.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-4)
        }
    }
    
    // MARK: GuideLabel
    func setupGuideLabel() {
        guideLabel.font = .font22P
        guideLabel.numberOfLines = 0
        guideLabel.textColor = .heroGray5B
        guideLabel.text = "발송된 이메일에 기재된\n인증번호를 입력해주세요."
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(22)
        }
    }
    
    // MARK: VerifyField
    func setupVerifyField() {
        verifyField.delegate = self
        verifyField.setPlaceHolder("인증번호를 입력해주세요")
        self.view.addSubview(verifyField)
        
        verifyField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(192)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: WrongLabel
    func setupWrongLabel() {
        wrongLabel.font = .font13P
        wrongLabel.isHidden = true
        wrongLabel.textColor = .heroServiceSubPink
        wrongLabel.text = "입력하신 인증번호가 일치하지 않습니다."
        self.view.addSubview(wrongLabel)
        
        wrongLabel.snp.makeConstraints { make in
            make.top.equalTo(verifyField.snp.bottom).offset(8)
            make.leading.equalTo(verifyField.snp.leading).offset(2)
        }
    }
    
    // MARK: NextButton
    func setupNextButton() {
        nextButton.setHeroEnable(false)
        nextButton.setHeroTitle("계속하기")
        nextButton.loginButtonType = .none
        nextButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: verifyField.bottomAnchor)
        nextButtonTopAnchor?.constant = 16
        nextButtonTopAnchor?.isActive = true
    }
}
