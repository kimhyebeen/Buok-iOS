//
//  ImageCell.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import Kingfisher

public class ImageCell: UICollectionViewCell {
    static let identifier: String = "ImageCell"
    private let imageView: UIImageView = UIImageView()
    
    public var index: Int = -1
    
    public var itemImage: String? {
        didSet {
            imageView.kf.setImage(with: URL(string: itemImage ?? ""))
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
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
        
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
}
