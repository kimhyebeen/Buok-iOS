//
//  BuokmarkCollectionCell.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/14.
//

import UIKit

class BuokmarkCollectionCell: UICollectionViewCell {
    static let identifier = "BuokmarkCollectionCell"
    let dateLabel = UILabel()
    let flagView = BuokmarkFlagView()
    let iconCircleView = UIView()
    let iconImageView = UIImageView()
    let buokLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupDateLabel()
        setupFlagView()
        setupIconCircleView()
        setupIconImageView()
        setupBuokLabel()
    }
    
    func setInformation(to model: BuokmarkFlag, color: UIColor) {
        // todo - 나중에 model 구조체로 생성해서 설정하도록 구현
        dateLabel.text = model.date
        buokLabel.text = model.title
        if #available(iOS 13.0, *) {
            iconImageView.image = UIImage(heroSharedNamed: model.category)!.withTintColor(color)
        } else {
            iconImageView.image = UIImage(heroSharedNamed: model.category)!
        }
        flagView.flagView.layer.backgroundColor = color.cgColor
    }
}

extension BuokmarkCollectionCell {
    // MARK: DateLabel
    private func setupDateLabel() {
        dateLabel.text = "yyyy.MM"
        dateLabel.textColor = .heroGrayA6A4A1
        dateLabel.font = .font13P
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: FlagView
    private func setupFlagView() {
        self.addSubview(flagView)
        
        flagView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(121)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: IconCircleView
    private func setupIconCircleView() {
        iconCircleView.layer.cornerRadius = 16
        iconCircleView.layer.backgroundColor = UIColor.white.cgColor
        self.addSubview(iconCircleView)
        
        iconCircleView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.centerY.equalToSuperview().offset(-8)
            make.leading.equalTo(flagView.snp.leading).offset(27)
        }
    }
    
    // MARK: IconImageView
    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
        self.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.center.equalTo(iconCircleView.snp.center)
        }
    }
    
    // MARK: BuokLabel
    private func setupBuokLabel() {
        buokLabel.text = "버킷리스트"
        buokLabel.textColor = .white
        buokLabel.font = .font15P
        buokLabel.numberOfLines = 0
        self.addSubview(buokLabel)
        
        buokLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-8)
            make.leading.equalTo(iconImageView.snp.trailing).offset(24)
            make.trailing.lessThanOrEqualTo(flagView.snp.trailing).offset(-31)
        }
    }
}
