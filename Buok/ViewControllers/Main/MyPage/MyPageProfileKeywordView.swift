//
//  MyPageProfileKeywordView.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class MyPageProfileKeywordView: UIView {
    private let contentView: UIView = {
        $0.backgroundColor = .heroGraySample200s
        $0.layer.cornerRadius = 4
        return $0
    }(UIView())
    
    private let keywordLabel: UILabel = {
        $0.font = .font12P
        $0.textColor = .heroGray600s
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(contentView)
        contentView.addSubview(keywordLabel)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.center.equalToSuperview()
        }
        
        keywordLabel.text = "샘플어워드"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
