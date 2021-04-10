//
//  CountContentView.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class CountContentView: UIView {
    private let titleLabel: UILabel = {
        $0.textColor = .heroGraySample200s
        $0.font = .font14P
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let countLabel: UILabel = {
        $0.textColor = .heroGray600s
        $0.font = .font20PBold
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(2)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
