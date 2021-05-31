//
//  BuokmarkEmptyCollectionCell.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import UIKit

class BuokmarkEmptyCollectionCell: UICollectionViewCell {
    static let identifier = "BuokmarkEmptyCollectionCell"
    private let flagView = BuokmarkFlagView()
    private let plusImageView = UIImageView()
    
    var isFirst: Bool = false {
        didSet {
            if isFirst {
                flagView.flagView.layer.backgroundColor = UIColor.heroPrimaryBeigeDark.cgColor
                plusImageView.isHidden = false
            } else {
                flagView.flagView.layer.backgroundColor = UIColor.heroPrimaryBeigeDown.cgColor
                plusImageView.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        
        setupFlagView()
        setupPlusImageView()
    }
    
    private func setupFlagView() {
        flagView.flagView.layer.backgroundColor = UIColor.heroPrimaryBeigeDown.cgColor
        self.addSubview(flagView)
        
        flagView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupPlusImageView() {
        if #available(iOS 13.0, *) {
            plusImageView.image = UIImage(heroSharedNamed: "ic_plus")!.withTintColor(.white)
        } else {
            plusImageView.image = UIImage(heroSharedNamed: "ic_plus")!
        }
        plusImageView.isHidden = true
        self.addSubview(plusImageView)
        
        plusImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.center.equalTo(flagView.flagView.snp.center)
        }
    }
}
