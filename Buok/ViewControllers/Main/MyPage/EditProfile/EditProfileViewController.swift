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
    
    let imagePicker = UIImagePickerController()
    
    private let viewModel = EditProfileViewModel()

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
        
        imagePicker.delegate = self
    }
    
    @objc
    func clickCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func clickFinishButton(_ sender: UIButton) {
        // todo - requestSaveProfile의 파라미터로 프로필 정보를 넘겨줘야 함
        viewModel.requestSaveProfile().then { [weak self] isSuccess in
            if isSuccess {
                self?.dismiss(animated: true, completion: nil)
            } else {
                // todo - 실패 처리
                self?.nicknameSubLabel.isHidden = false
            }
        }
    }
    
    @objc
    func clickEditProfileImageButton(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
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

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.profileImageView.image = selectedImage
        let imageData = selectedImage.jpegData(compressionQuality: 0.5) // 추후 서버에 저장할 때 필요
        
        self.dismiss(animated: true, completion: nil)
    }
}
