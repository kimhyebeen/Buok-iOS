//
//  BucketBookHeaderButton.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroUI

class BucketBookHeaderButton: UIButton {
    private let bucketBookLabel = UILabel()
    
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
        
        bucketBookLabel.text = "Hero_Profile_BucketBook".localized
        bucketBookLabel.textColor = .heroGray5B
        bucketBookLabel.font = .font20PBold
        self.addSubview(bucketBookLabel)
        
        bucketBookLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func selectedMode() {
        self.layer.backgroundColor = UIColor.heroPrimaryBeigeLighter.cgColor
        bucketBookLabel.font = .font20PBold
    }
    
    private func nonSelectedMode() {
        self.layer.backgroundColor = UIColor.heroServiceSkin.cgColor
        bucketBookLabel.font = .font20P
    }
}
