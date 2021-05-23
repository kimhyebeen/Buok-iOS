//
//  FriendListCollectionCell.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/24.
//

import UIKit

class FriendListCollectionCell: UICollectionViewCell {
    private let profileImageView = UIImageView()
    private let userLabel = UILabel()
    private let introLabel = UILabel()
    private let friendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupProfileImageVIew()
        setupUserLabel()
        setupIntroLabel()
        setupFriendButton()
    }
}

extension FriendListCollectionCell {
    // MARK: ProfileImageView
    private func setupProfileImageVIew() {
        
    }
    
    // MARK: UserLabel
    private func setupUserLabel() {
        
    }
    
    // MARK: IntroLabel
    private func setupIntroLabel() {
        
    }
    
    // MARK: FriendButton
    private func setupFriendButton() {
        
    }
}
