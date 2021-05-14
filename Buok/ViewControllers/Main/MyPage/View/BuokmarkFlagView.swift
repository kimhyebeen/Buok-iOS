//
//  BuokmarkFlagView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/14.
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
        flagView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        flagView.layer.backgroundColor = UIColor.heroPrimaryBeigeDark.cgColor
        self.addSubview(flagView)
        
        flagView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(flagLine.snp.trailing)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
