//
//  SignUpIntroduceViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

class JoinIntroduceViewController: HeroBaseViewController {
    let backButton = UIButton()
    let guideLabel = UILabel()
    let enterField = IntroduceTextView()
    let placeholder = UILabel()
    let countLabel = UILabel()
    let finishButton = LoginButton()
    let passButton = UIButton()
    
    weak var viewModel: UserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.isSignUpSuccess.bind({ [weak self] value in
            self?.navigationController?.popToRootViewController(animated: true)
        })
        
        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupGuideLabel()
        setupEnterField()
        setupPlaceholder()
        setupCountLabel()
        setupFinishButton()
        setupPassButton()
    }

    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickFinishButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.introduce = enterField.text
        
        guard let token = viewmodel.requestJoin() else {
            // todo - 로그인 실패 처리
            return
        }
        // todo - 토큰 저장 후, 메인 화면 이동
    }
    
    @objc
    func clickPassButton(_ sender: UIButton) {
        guard let viewmodel = viewModel else { return }
        viewmodel.introduce = nil
        
        guard let token = viewmodel.requestJoin() else {
            // todo - 로그인 실패 처리
            return
        }
        // todo - 토큰 저장 후, 메인 화면 이동
    }
}

// MARK: Delegate
extension JoinIntroduceViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        countLabel.text = "\(textView.text.count)/75"
        if textView.text.count > 75 || textView.numberOfLine() > 3 {
            let start = textView.text.startIndex
            let beforeEnd = textView.text.index(before: textView.text.endIndex)
            textView.text = String(textView.text[start..<beforeEnd])
        }
        finishButton.loginButtonType = .none
        finishButton.setHeroEnable(!textView.text.isEmpty)
    }
}
