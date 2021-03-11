//
//  TagView.swift
//  HeroUI
//
//  Created by 김혜빈 on 2021/03/11.
//

import UIKit
import SnapKit

public class TagView: UIView {
    private var keywordLabel = UILabel()
    public var keyword: String = "" {
        didSet {
            keywordLabel.text = "# \(keyword)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(hex: "#d2d2d2", alpha: 0.4)
        self.layer.cornerRadius = 10
        setupKeywordLabel()
    }
    
    private func setupKeywordLabel() {
        keywordLabel.textColor = .heroWhite100s
        keywordLabel.font = .font14PBold
        self.addSubview(keywordLabel)
        
        keywordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }

}
