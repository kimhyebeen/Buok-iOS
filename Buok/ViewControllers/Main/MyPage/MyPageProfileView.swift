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
        $0.backgroundColor = .heroGraySample200s
        $0.layer.cornerRadius = 30
        return $0
    }(UIImageView())
    
    private let profileContentView: UIView = UIView()
    private let profileNameLabel: UILabel = {
        $0.font = .font17PBold
        $0.textColor = .heroGray600s
        return $0
    }(UILabel())
    
    private let profileAwardKeywordView: MyPageProfileKeywordView = MyPageProfileKeywordView()
    
    private let profileCountView: MyPageProfileCountView = MyPageProfileCountView()
    private let profileMessageSectionView: UIView = UIView()
    private let profileMessageLabel: UILabel = {
        $0.numberOfLines = 3
        $0.font = .font14P
        $0.textColor = .heroGray600s
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        backgroundColor = .heroGraySample100s
        addSubview(profileImageSectionView)
        profileImageSectionView.addSubview(profileImageView)
        profileImageSectionView.addSubview(profileContentView)
        profileContentView.addSubview(profileNameLabel)
        profileContentView.addSubview(profileAwardKeywordView)
        
        addSubview(profileCountView)
        addSubview(profileMessageSectionView)
        profileMessageSectionView.addSubview(profileMessageLabel)
        
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
        
        profileCountView.snp.makeConstraints { make in
            make.top.equalTo(profileImageSectionView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(64)
        }
        
        DebugLog("ProfileView - profileCountView Width : \(profileCountView.frame.width)")
        
        profileMessageSectionView.snp.makeConstraints { make in
            make.top.equalTo(profileCountView.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        
        profileMessageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileNameLabel.text = "홍길동"
        profileMessageLabel.text = "안녕하세요\n홍길동의 버킷리스트입니다.\n세줄까지 보여줄 수 있고 그 밑 부터는 줄여서 표현"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
