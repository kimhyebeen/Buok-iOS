//
//  FriendPageHeaderView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import UIKit

protocol FriendPageBuokmarkHeaderViewDelegate: AnyObject {
    func reloadCollectionView()
}

class FriendPageBuokmarkHeaderView: UIView {
    private let buokmarkButton = BuokmarkHeaderButton()
    private let bucketBookButton = BucketBookHeaderButton()
    
    var isSelectBuokmarkButton: Bool {
        self.buokmarkButton.isSelected
    }
    var isSelectBucketBookButton: Bool {
        self.bucketBookButton.isSelected
    }
    
    var countOfBuokmark: Int = 0 {
        didSet {
            buokmarkButton.count = countOfBuokmark
        }
    }
    
    weak var delegate: FriendPageBuokmarkHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = .heroServiceSkin
        
        setupBuokmarkButton()
        setupBucketBookButton()
    }
    
    @objc
    func clickBuokmarkButton(_ sender: UIButton) {
        if buokmarkButton.isSelected { return }
        delegate?.reloadCollectionView()
        buokmarkButton.isSelected = !buokmarkButton.isSelected
        bucketBookButton.isSelected = !bucketBookButton.isSelected
    }
    
    @objc
    func clickBucketBookButton(_ sender: UIButton) {
        if bucketBookButton.isSelected { return }
        delegate?.reloadCollectionView()
        buokmarkButton.isSelected = !buokmarkButton.isSelected
        bucketBookButton.isSelected = !bucketBookButton.isSelected
    }
}

extension FriendPageBuokmarkHeaderView {
    // MARK: BuokmarkButton
    private func setupBuokmarkButton() {
        buokmarkButton.isSelected = true
        buokmarkButton.addTarget(self, action: #selector(clickBuokmarkButton(_:)), for: .touchUpInside)
        self.addSubview(buokmarkButton)
        
        buokmarkButton.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX)
        }
    }
    
    // MARK: BucketBookButton
    private func setupBucketBookButton() {
        bucketBookButton.isSelected = false
        bucketBookButton.addTarget(self, action: #selector(clickBucketBookButton(_:)), for: .touchUpInside)
        self.addSubview(bucketBookButton)
        
        bucketBookButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(self.snp.centerX)
        }
    }
}
