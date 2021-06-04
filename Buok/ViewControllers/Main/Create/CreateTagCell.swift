//
//  CreateTagCell.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/23.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public protocol TagCellDelegate: AnyObject {
    func onClickDeleteButton(index: Int)
}

public class CreateTagCell: UICollectionViewCell {
    static let identifier: String = "CreateTagCell"
    private let cellBackgroundView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    
    private let deleteButton: UIButton = UIButton()
    private let deleteImageView: UIImageView = UIImageView()
    
    public var itemIndex: Int = 0
    public weak var delegate: TagCellDelegate?
    
    public var itemTitle: String? {
        didSet {
            titleLabel.text = itemTitle
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
        cellBackgroundView.addSubview(deleteButton)
        deleteButton.addSubview(deleteImageView)
        
        cellBackgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(3)
            make.trailing.equalToSuperview().offset(-5)
            make.width.height.equalTo(12)
        }
        
        deleteImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.font = .font15P
        titleLabel.textColor = .heroWhite100s
        cellBackgroundView.backgroundColor = .heroGrayC7BFB8
        cellBackgroundView.layer.cornerRadius = 8
        
        deleteImageView.image = UIImage(heroSharedNamed: "ic_x")?.withRenderingMode(.alwaysTemplate)
        deleteImageView.tintColor = .heroGrayF2EDE8
        deleteButton.addTarget(self, action: #selector(onClickDelete(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickDelete(_ sender: UIButton) {
        delegate?.onClickDeleteButton(index: itemIndex)
    }
}
