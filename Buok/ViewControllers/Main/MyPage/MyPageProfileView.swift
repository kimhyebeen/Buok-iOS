//
//  MyPageProfileView.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class MyPageProfileView: UIView {
    public var profile: Profile? {
        didSet {
            profileNameLabel.text = profile?.nickname
            profileMessageLabel.text = profile?.statusMessage
        }
    }
    
    private let profileImageSectionView: UIView = UIView()
    private let profileImageView: UIImageView = {
        $0.backgroundColor = .heroGray600s
        return $0
    }(UIImageView())
    
    private let profileContentView: UIView = UIView()
    private let profileNameLabel: UILabel = UILabel()
    private let profileAwardKeywordView: MyPageProfileKeywordView = MyPageProfileKeywordView()
    
    private let profileCountView: MyPageProfileCountView = MyPageProfileCountView()
    private let profileMessageSectionView: UIView = UIView()
    private let profileMessageLabel: UILabel = {
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        addSubview(profileImageSectionView)
        profileImageSectionView.addSubview(profileImageView)
        profileImageSectionView.addSubview(profileContentView)
        profileContentView.addSubview(profileNameLabel)
        profileContentView.addSubview(profileAwardKeywordView)
        
        profileImageSectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        profileContentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalToSuperview()
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        profileAwardKeywordView.snp.makeConstraints { make in
            make.top.equalTo(profileNameLabel.snp.bottom).offset(4)
            make.left.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
