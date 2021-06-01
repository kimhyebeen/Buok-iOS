//
//  MypageCountingStackView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import UIKit

class MypageCountingStackView: UIStackView {
    let friendButton = MypageCountingButton()
    let bucketButton = MypageCountingButton()
    
    var friendCount: Int = 0 {
        didSet {
            friendButton.count = friendCount
        }
    }
    var bucketCount: Int = 0 {
        didSet {
            bucketButton.count = bucketCount
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = UIColor.white.cgColor
        self.distribution = .fillEqually
        self.axis = .horizontal
        
        setupFriendButton()
        setupBucketButton()
        setupDivider()
    }

}

extension MypageCountingStackView {
    // MARK: FriendButton
    func setupFriendButton() {
        friendButton.count = 0
        friendButton.mainText = "친구"
        self.addArrangedSubview(friendButton)
    }
    
    // MARK: Divider
    private func setupDivider() {
        let divider = UIView()
        divider.backgroundColor = .heroGrayscale200
        self.addSubview(divider)
        
        divider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: BucketButton
    func setupBucketButton() {
        bucketButton.count = 0
        bucketButton.mainText = "버킷"
        self.addArrangedSubview(bucketButton)
    }
}
