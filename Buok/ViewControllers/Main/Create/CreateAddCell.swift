//
//  CreateAddCell.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/22.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class CreateAddCell: UICollectionViewCell {
    static let identifier: String = "CreateAddCell"
    private let cellBackgroundView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(imageView)
        
        cellBackgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        cellBackgroundView.backgroundColor = .heroGrayC7BFB8
        cellBackgroundView.layer.cornerRadius = 8
        imageView.image = UIImage(heroSharedNamed: "ic_plus_white")
    }
}
