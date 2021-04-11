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
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    private let arrowView: UIImageView = {
        $0.image = UIImage(heroSharedNamed: "ic_right_arrow")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .heroGraySample300s
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
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
        switch cellType {
        case .normal:
            contentLabel.isHidden = false
            arrowView.isHidden = true
        case .button:
            contentLabel.isHidden = true
            arrowView.isHidden = false
        default:
            contentLabel.isHidden = true
            arrowView.isHidden = true
        }
    }
    
    private func setupCellLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(arrowView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        arrowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
    }
}
