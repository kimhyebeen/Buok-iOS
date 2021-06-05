//
//  BucketBookHeaderButton.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroUI

class BucketBookHeaderButton: UIButton {
    private let bucketBookLabel = UILabel()
    private let bucketCountLabel = UILabel()
    private let stackView = UIStackView()
    
    var count: Int = 0 {
        didSet {
            if count < 10 {
                bucketCountLabel.text = "0\(count)"
            } else if count < 100 {
                bucketCountLabel.text = "\(count)"
            } else { bucketCountLabel.text = "99+" }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.selectedMode()
            } else { self.nonSelectedMode() }
        }
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.backgroundColor = UIColor.heroPrimaryBeigeLighter.cgColor
        
        setupStackView()
        setupBucketLabel()
        setupBucketCountLabel()
    }
    
    private func selectedMode() {
        self.layer.backgroundColor = UIColor.heroPrimaryBeigeLighter.cgColor
        bucketBookLabel.font = .font20PBold
    }
    
    private func nonSelectedMode() {
        self.layer.backgroundColor = UIColor.heroServiceSkin.cgColor
        bucketBookLabel.font = .font20P
    }
    
    private func setupBucketLabel() {
        bucketBookLabel.text = "Hero_Profile_BucketBook".localized
        bucketBookLabel.font = .font20PBold
        bucketBookLabel.textColor = .heroGray5B
        stackView.addArrangedSubview(bucketBookLabel)
    }
    
    private func setupBucketCountLabel() {
        bucketCountLabel.text = "00"
        bucketCountLabel.textColor = .heroPrimaryPink
        bucketCountLabel.font = .font20PBold
        stackView.addArrangedSubview(bucketCountLabel)
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.isUserInteractionEnabled = false
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
