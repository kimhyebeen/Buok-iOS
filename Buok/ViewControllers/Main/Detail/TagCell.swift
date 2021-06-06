//
//  TagCell.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class TagCell: UICollectionViewCell {
    static let identifier: String = "TagCell"
    private let cellBackgroundView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    
    public var itemIndex: Int = 0
    
    public var itemTitle: String? {
        didSet {
            titleLabel.text = "#\(itemTitle ?? "")"
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(titleLabel)
        
        cellBackgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        titleLabel.font = .font15P
        titleLabel.textColor = .heroGray5B
        cellBackgroundView.backgroundColor = .heroGrayF2EDE8
        cellBackgroundView.layer.cornerRadius = 8
    }
}
