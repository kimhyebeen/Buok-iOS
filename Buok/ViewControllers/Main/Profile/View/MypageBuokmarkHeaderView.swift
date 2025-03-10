//
//  MypageBuokmarkHeaderView.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import UIKit

class MypageBuokmarkHeaderView: UIView {
    private let buokmarkLabel = UILabel()
    private let buokmarkCountLabel = UILabel()
    
    var count: Int = 0 {
        didSet {
            if count > 99 {
                buokmarkCountLabel.text = "99+"
            } else {
                buokmarkCountLabel.text = "\(count < 10 ? "0" : "")\(count)"
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
        backgroundColor = .heroGrayF2EDE8
        setupBuokmarkLabel()
        setupBuokmarkCountLabel()
    }

}

extension MypageBuokmarkHeaderView {
    // MARK: BuokmarkLabel
    private func setupBuokmarkLabel() {
        buokmarkLabel.text = "북마크"
        buokmarkLabel.textColor = .heroGray5B
        buokmarkLabel.font = .font20PBold
        self.addSubview(buokmarkLabel)
        
        buokmarkLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: BuokmarkCountLabel
    private func setupBuokmarkCountLabel() {
        buokmarkCountLabel.text = "00"
        buokmarkCountLabel.textColor = .heroPrimaryPink
        buokmarkCountLabel.font = .font20PBold
        self.addSubview(buokmarkCountLabel)
        
        buokmarkCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(buokmarkLabel.snp.centerY)
            make.leading.equalTo(buokmarkLabel.snp.trailing).offset(4)
        }
    }
}
