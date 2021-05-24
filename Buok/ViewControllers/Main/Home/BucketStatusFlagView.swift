//
//  BucketStatusFlagView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/24.
//

import HeroUI

enum BucketStatusType {
    case inProgress
    case expected
    case done
    case fail
}

class BucketStatusFlagView: UIView {
    private let topView = UIView()
    private let bottomView = UIView()
    private let statusLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupStatusLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func settingBucketType(to type: BucketStatusType) {
        switch type {
        case .inProgress:
            topView.layer.backgroundColor = UIColor.heroServiceNavy.cgColor
            bottomView.layer.backgroundColor = UIColor.heroServiceNavy.cgColor
            statusLabel.text = "Hero_Add_Bucket_Present".localized
        case .expected:
            topView.layer.backgroundColor = UIColor.heroPrimaryBlue.cgColor
            bottomView.layer.backgroundColor = UIColor.heroPrimaryBlue.cgColor
            statusLabel.text = "Hero_Add_Bucket_Predestination".localized
        case .fail:
            topView.layer.backgroundColor = UIColor.heroPrimaryPink.cgColor
            bottomView.layer.backgroundColor = UIColor.heroPrimaryPink.cgColor
            statusLabel.text = "Hero_Add_Bucket_Failure".localized
        default:
            topView.layer.backgroundColor = UIColor.heroPrimaryPink.cgColor
            bottomView.layer.backgroundColor = UIColor.heroPrimaryPink.cgColor
            statusLabel.text = "Hero_Home_Filter_Done".localized
        }
    }
    
    private func setupView() {
        topView.layer.cornerRadius = 2
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topView.layer.backgroundColor = UIColor.heroServiceNavy.cgColor
        self.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        
        bottomView.layer.cornerRadius = 6
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.backgroundColor = UIColor.heroServiceNavy.cgColor
        self.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupStatusLabel() {
        statusLabel.text = "Hero_Add_Bucket_Present".localized
        statusLabel.textColor = .white
        statusLabel.font = .font13P
        self.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
        }
    }
}
