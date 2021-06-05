//
//  BucketCollectionCell.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/24.
//

import HeroUI

class BucketCollectionCell: UICollectionViewCell {
    static let identifier = "BucketCollectionCell"
    private let flagView = BucketStatusFlagView()
    private let categoryCircleBackgroundView = UIView()
    private let categoryImageView = UIImageView()
    private let bucketLabel = UILabel()
    private let dateLabel = UILabel()
    private let lockImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setInformation(_ text: String, _ type: BucketStatusType) {
        // todo - 추후 수정 필요
        bucketLabel.text = text
        
        flagView.settingBucketType(to: type)
        if type == .done || type == .fail {
            dateLabel.textColor = .heroPrimaryPinkLight
        } else {
            dateLabel.textColor = .heroGrayA6A4A1
        }
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = UIColor.white.cgColor
        
        setupFlagView()
        setupCategoryCircle()
        setupCategoryImageView()
        setupBucketLabel()
        setupDateLabel()
        setupLockImageView()
    }
}

extension BucketCollectionCell {
    // MARK: FlagView
    private func setupFlagView() {
        self.addSubview(flagView)
        
        flagView.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    // MARK: CategoryCircle
    private func setupCategoryCircle() {
        categoryCircleBackgroundView.layer.cornerRadius = 18
        categoryCircleBackgroundView.layer.backgroundColor = UIColor.heroGrayscale200.cgColor
        categoryCircleBackgroundView.layer.backgroundColor = UIColor.systemGray5.cgColor
        self.addSubview(categoryCircleBackgroundView)
        
        categoryCircleBackgroundView.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: CategoryImageView
    private func setupCategoryImageView() {
        categoryImageView.image = UIImage(heroSharedNamed: "ic_fill_travel")?.withTintColor(.heroGrayA6A4A1)
        self.addSubview(categoryImageView)
        
        categoryImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.center.equalTo(categoryCircleBackgroundView.snp.center)
        }
    }
    
    // MARK: BucketLabel
    private func setupBucketLabel() {
        bucketLabel.text = "카카오톡 이모티콘 런칭 성공하기"
        bucketLabel.textColor = .heroGray5B
        bucketLabel.numberOfLines = 0
        bucketLabel.font = .font17P
        bucketLabel.textAlignment = .center
        self.addSubview(bucketLabel)
        
        bucketLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(12)
            make.trailing.lessThanOrEqualToSuperview().offset(-12)
        }
    }
    
    // MARK: DateLabel
    private func setupDateLabel() {
        dateLabel.text = "D - 120"
        dateLabel.textColor = .heroGrayA6A4A1
        dateLabel.font = .font13P
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: LockImageView
    private func setupLockImageView() {
        lockImageView.image = UIImage(heroSharedNamed: "ic_lock")?.withTintColor(.heroGrayA6A4A1)
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.isHidden = true
        self.addSubview(lockImageView)
        
        lockImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-9)
        }
    }
}
