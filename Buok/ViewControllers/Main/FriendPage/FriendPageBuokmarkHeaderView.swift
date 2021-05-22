//
//  FriendPageHeaderView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import UIKit

class FriendPageBuokmarkHeaderView: UIView {
    let buokmarkButton = BuokmarkHeaderButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupBuokmarkButton()
        setupBucketBookButton()
    }
}

extension FriendPageBuokmarkHeaderView {
    // MARK: BuokmarkButton
    private func setupBuokmarkButton() {
        buokmarkButton.isSelected = true
        self.addSubview(buokmarkButton)
        
        buokmarkButton.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX)
        }
    }
    
    // MARK: BucketBookButton
    private func setupBucketBookButton() {
        
    }
}
