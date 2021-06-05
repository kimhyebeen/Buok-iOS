//
//  BucketItemCell.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/04.
//

import Foundation
import HeroCommon
import HeroUI

final class BucketItemCell: UICollectionViewCell {
    static let identifier: String = "BucketItemCell"
    
    private let stateView: BucketStateView = BucketStateView()
    private let contentBgView: UIView = UIView()
    private let iconContainerView: UIView = UIView()
    private let iconImageView: UIImageView = UIImageView()
    
    private let titleLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    public var bucket: BucketModel? {
        didSet {
            titleLabel.text = bucket?.bucketName
            self.updateContentBgView()
            self.setupCategoryIcon()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        contentView.addSubview(contentBgView)
        contentView.addSubview(stateView)
        contentBgView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        
        contentBgView.addSubview(titleLabel)
        contentBgView.addSubview(dateLabel)
        
        contentBgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        iconContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.height.equalTo(36)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stateView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(36)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
        
        contentBgView.layer.cornerRadius = 8
        iconContainerView.layer.cornerRadius = 18
        
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = .heroGray5B
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    private func setupCategoryIcon() {
        iconImageView.image = BucketCategory(rawValue: (bucket?.categoryId ?? 2) - 2)?.getIcon()?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .heroGrayA6A4A1
    }
    
    private func updateContentBgView() {
        let state = BucketState(rawValue: bucket?.bucketState ?? 2) ?? .now
        stateView.state = state
        
        if state == .failure {
            iconContainerView.backgroundColor = .heroGrayF2EDE8
            contentBgView.backgroundColor = .heroGrayE7E1DC
            contentBgView.layer.shadowRadius = 0
            contentBgView.layer.shadowColor = UIColor.clear.cgColor
            contentBgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        } else {
            iconContainerView.backgroundColor = .heroGrayF1F1F1
            contentBgView.backgroundColor = .heroWhite100s
            contentBgView.layer.shadowRadius = 8
            contentBgView.layer.shadowColor = UIColor.heroGrayC7BFB8.cgColor
            contentBgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        }
        
        updateLabelProperty(state: state)
        setDateToLabel(state: state)
    }
    
    private func updateLabelProperty(state: BucketState) {
        var textColor: UIColor?
        var font: UIFont?
        
        switch state {
        case .now:
            textColor = .heroGrayA6A4A1
            font = UIFont.systemFont(ofSize: 13, weight: .regular)
        case .expect:
            textColor = .heroGrayA6A4A1
            font = UIFont.systemFont(ofSize: 13, weight: .regular)
        case .done:
            textColor = .heroPrimaryPink
            font = UIFont.systemFont(ofSize: 13, weight: .bold)
        case .failure:
            textColor = .heroGrayA6A4A1
            font = UIFont.systemFont(ofSize: 13, weight: .regular)
        case .all:
            break
        }
        
        dateLabel.textColor = textColor
        dateLabel.font = font
    }
    
    private func setDateToLabel(state: BucketState) {
        if state == .failure || state == .done {
            dateLabel.text = bucket?.endDate.convertToDate().convertToSmallString()
        } else {
            if let endDate = bucket?.endDate.convertToDate() {
                if Calendar.current.dateComponents([.day], from: endDate, to: Date()).day == 0 {
                    dateLabel.text = "D - Day"
                } else {
                    dateLabel.text = "D - \(Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0)"
                }
            }
        }
    }
}
