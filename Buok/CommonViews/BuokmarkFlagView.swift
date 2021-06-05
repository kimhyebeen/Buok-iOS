//
//  BuokmarkFlagView.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import UIKit

class BuokmarkFlagView: UIView {
    let flagLine = UIView()
    let flagView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupFlagLine()
        setupFlagView()
    }
    
    private func setupFlagLine() {
        flagLine.backgroundColor = .white
        self.addSubview(flagLine)
        
        flagLine.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.top.bottom.leading.equalToSuperview()
        }
    }
    
    private func setupFlagView() {
        flagView.layer.cornerRadius = 8
        flagView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        flagView.layer.backgroundColor = UIColor.heroPrimaryPink.cgColor
        self.addSubview(flagView)
        
        flagView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(flagLine.snp.trailing)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
