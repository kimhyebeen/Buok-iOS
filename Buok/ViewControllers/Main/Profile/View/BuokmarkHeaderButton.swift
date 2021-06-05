//
//  BuokmarkHeaderButton.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

class BuokmarkHeaderButton: UIButton {
    private let buokmarkLabel = UILabel()
    private let buokmarkCountLabel = UILabel()
    private let stackView = UIStackView()
    
    var count: Int = 0 {
        didSet {
            if count < 10 {
                buokmarkCountLabel.text = "0\(count)"
            } else if count < 100 {
                buokmarkCountLabel.text = "\(count)"
            } else { buokmarkCountLabel.text = "99+" }
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
        
        setupBuokmarkLabel()
        setupBuokmarkCountLabel()
        setupStackView()
    }
    
    private func selectedMode() {
        self.layer.backgroundColor = UIColor.heroPrimaryBeigeLighter.cgColor
        buokmarkLabel.font = .font20PBold
        buokmarkCountLabel.isHidden = false
    }
    
    private func nonSelectedMode() {
        self.layer.backgroundColor = UIColor.heroServiceSkin.cgColor
        buokmarkLabel.font = .font20P
        buokmarkCountLabel.isHidden = true
    }
    
    private func setupBuokmarkLabel() {
        buokmarkLabel.text = "Hero_Profile_Buokmark".localized
        buokmarkLabel.font = .font20PBold
        buokmarkLabel.textColor = .heroGray5B
        stackView.addArrangedSubview(buokmarkLabel)
    }
    
    private func setupBuokmarkCountLabel() {
        buokmarkCountLabel.text = "00"
        buokmarkCountLabel.textColor = .heroPrimaryPink
        buokmarkCountLabel.font = .font20PBold
        stackView.addArrangedSubview(buokmarkCountLabel)
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
