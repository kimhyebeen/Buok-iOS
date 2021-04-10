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
        }
    }
    
    private let titleLabel: UILabel = {
        $0.font = .font14P
        $0.textColor = .heroGraySample300s
        return $0
    }(UILabel())
    
    private let contentLabel: UILabel = {
        $0.font = .font14P
        $0.textColor = .heroGray600s
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
        
    }
}
