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
    let editProfileImageButton = UIButton()
    let nicknameLabel = UILabel()
    let nicknameTextField = UserTextField()
    let nicknameSubLabel = UILabel()
    let nicknameCountLabel = UILabel()
    let introduceLabel = UILabel()
    let introduceTextView = IntroduceTextView()
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
        setupEditProfileImageButton()
        setupNicknameLabel()
        setupNicknameTextField()
        setupNicknameSubLabel()
        setupNicknameCountLabel()
        setupIntroduceLabel()
        setupIntroduceTextView()
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
