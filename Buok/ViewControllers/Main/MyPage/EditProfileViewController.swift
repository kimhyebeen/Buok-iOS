//
//  EditProfileViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroUI

class EditProfileViewController: HeroBaseViewController {
    let titleLabel = UILabel()
    let cancelButton = UIButton()
    let finishButton = UIButton()
    let profileImageView = UIImageView()
    let editProfileImageButtonBackgroundCircle = UIView()
    let editProfileImageButton = UIButton()
    let nicknameLabel = UILabel()
    let nicknameTextField = UserTextField()
    let nicknameSubLabel = UILabel()
    let nicknameCountLabel = UILabel()
    let introduceLabel = UILabel()
    let introduceTextView = IntroduceTextView()
    let introducePlaceholder = UILabel()
    let introduceCountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupCancelButton()
        setupTitleLabel()
        setupFinishButton()
        setupProfileImageView()
        setupEditProfileImageButtonBackgroundCircle()
        setupEditProfileImageButton()
        setupNicknameLabel()
        setupNicknameTextField()
        setupNicknameSubLabel()
        setupNicknameCountLabel()
        setupIntroduceLabel()
        setupIntroduceTextView()
        setupIntroducePlaceholder()
        setupIntroduceCountLabel()
    }
    
    @objc
    func clickCancelButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickFinishButton(_ sender: UIButton) {
        // todo - 프로필을 저장하거나, 닉네임 중복 실패 처리
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickEditProfileImageButton(_ sender: UIButton) {
        // todo - 프로필 이미지 편집 기능
    }
}

// MARK: +Delegate
extension EditProfileViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard var text = textField.text else {
            self.nicknameCountLabel.text = "0/12"
            return
        }
        if text.count > 12 {
            text.removeLast()
            self.nicknameTextField.text = text
        }
        self.nicknameCountLabel.text = "\(text.count)/12"
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        introducePlaceholder.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        introducePlaceholder.isHidden = textView.text.count != 0
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        introduceCountLabel.text = "\(textView.text.count)/75"
        if textView.text.count > 75 || textView.numberOfLine() > 3 {
            let start = textView.text.startIndex
            let beforeEnd = textView.text.index(before: textView.text.endIndex)
            textView.text = String(textView.text[start..<beforeEnd])
        }
    }
}
