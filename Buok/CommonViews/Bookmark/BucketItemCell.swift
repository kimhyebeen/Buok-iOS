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
    private let stateView: BucketStateView = BucketStateView()
    private let contentBgView: UIView = UIView()
    private let iconContainerView: UIView = UIView()
    private let iconImageView: UIImageView = UIImageView()
    
    private let titleLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    public var bucket: BucketModel? {
        didSet {
            
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
        addSubview(contentBgView)
        addSubview(stateView)
        contentBgView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        
        contentBgView.addSubview(titleLabel)
        contentBgView.addSubview(dateLabel)
        
        contentBgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentBgView.layer.cornerRadius = 8
    }
    
    private func updateContentBgView() {
        bucket?.bucketState
        contentBgView.layer.shadowRadius = 8
        contentBgView.layer.shadowColor = UIColor.heroGrayC7BFB8.cgColor
        contentBgView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
