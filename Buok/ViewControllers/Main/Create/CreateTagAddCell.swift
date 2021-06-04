//
//  CreateTagAddCell.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/23.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public protocol TagAddCellDelegate: AnyObject {
    func onClickAddButton()
}

public class CreateTagAddCell: UICollectionViewCell {
    static let identifier: String = "CreateTagAddCell"
    private let cellBackgroundView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let entireButton: UIButton = UIButton()
    
    public weak var delegate: TagAddCellDelegate?
    
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
        cellBackgroundView.addSubview(entireButton)
        
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
        
        entireButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.text = "태그 추가"
        titleLabel.font = .font15P
        titleLabel.textColor = .heroGrayA6A4A1
        cellBackgroundView.backgroundColor = .heroWhite100s
        cellBackgroundView.layer.cornerRadius = 8
        
        entireButton.setTitle("", for: .normal)
        entireButton.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickButton(_ sender: UIButton) {
        delegate?.onClickAddButton()
    }
}
