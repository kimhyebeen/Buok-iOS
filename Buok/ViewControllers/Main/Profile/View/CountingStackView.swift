//
//  CountingStackView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import UIKit

protocol CountingStackViewDelegate: AnyObject {
    func onClickStackItem(type: CountingType)
}

enum CountingType: Int {
    case friend = 0
    case bucket = 1
}

class CountingStackView: UIStackView {
    let friendButton = CountingButton()
    let bucketButton = CountingButton()
    
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

    weak var delegate: CountingStackViewDelegate?
    
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
    
    @objc
    private func onClickFriendButton(_ sender: UIButton) {
        delegate?.onClickStackItem(type: .friend)
    }

    @objc
    private func onClickBucketButton(_ sender: UIButton) {
        delegate?.onClickStackItem(type: .bucket)
    }
}

extension CountingStackView {
    // MARK: FriendButton
    func setupFriendButton() {
        friendButton.count = 0
        friendButton.mainText = "친구"
        friendButton.addTarget(self, action: #selector(onClickFriendButton(_:)), for: .touchUpInside)
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
        bucketButton.addTarget(self, action: #selector(onClickBucketButton(_:)), for: .touchUpInside)
        self.addArrangedSubview(bucketButton)
    }
}
