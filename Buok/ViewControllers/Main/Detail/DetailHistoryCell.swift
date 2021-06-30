//
//  DetailHistoryCell.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class DetailHistoryCell: UITableViewCell {
    static let identifier: String = "DetailHistoryCell"
    private let dateLabel: UILabel = UILabel()
    private let contentLabel: UILabel = UILabel()
    
    var historyItem: BucketHistoryModel? {
        didSet {
            dateLabel.text = historyItem?.modifiedDate.convertToDate().convertToSmallDotString()
            contentLabel.text = historyItem?.content
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(contentLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(88)
            make.bottom.greaterThanOrEqualToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
        }
        
        dateLabel.font = .font12P
        contentLabel.font = .font13P
        
        dateLabel.textColor = .heroGrayA6A4A1
        contentLabel.textColor = .heroGray5B
        contentLabel.numberOfLines = 0
    }
}
