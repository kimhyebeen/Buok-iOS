//
//  SettingInfoCell.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class SettingInfoCell: UITableViewCell {
    static let identifier: String = "SettingInfoCell"
    var type: SettingType? {
        didSet {
            titleLabel.text = type?.getTitle()
            contentLabel.text = "최신 1.11.1 사용 중"
        }
    }
    
    private let titleLabel: UILabel = {
        $0.font = .font14P
        $0.textColor = .heroGray82
        return $0
    }(UILabel())
    
    private let contentLabel: UILabel = {
        $0.font = .font14P
        $0.textColor = .heroGray5B
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
