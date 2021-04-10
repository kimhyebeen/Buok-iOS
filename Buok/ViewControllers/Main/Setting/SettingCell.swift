//
//  SettingCell.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class SettingCell: UITableViewCell {
    static let identifier: String = "SettingCell"
    var type: SettingType? {
        didSet {
            titleLabel.text = type?.getTitle()
        }
    }
    
    private let titleLabel: UILabel = {
        $0.font = .font14P
        $0.textColor = .heroGraySample300s
        return $0
    }(UILabel())
    
    var cellType: SettingCellType = .normal {
        didSet {
            updateViewType()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViewType() {
        
    }
    
    private func setupCellLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
    }
}
