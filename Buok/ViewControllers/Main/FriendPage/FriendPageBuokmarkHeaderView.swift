//
//  FriendPageHeaderView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import UIKit

class FriendPageBuokmarkHeaderView: UIView {
    
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
        
    }
    
    // MARK: BucketBookButton
    private func setupBucketBookButton() {
        
    }
}
