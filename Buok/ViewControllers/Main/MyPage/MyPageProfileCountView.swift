//
//  MyPageProfileCountView.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class MyPageProfileCountView: UIView {
    private let contentView: UIView = {
        $0.backgroundColor = .heroWhite100s
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        return $0
    }(UIView())
    
    private let contentStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private let separator1: UIView = {
        $0.backgroundColor = .heroGraySample300s
        return $0
    }(UIView())
    
    private let separator2: UIView = {
        $0.backgroundColor = .heroGraySample300s
        return $0
    }(UIView())
    
    private let friendButton: UIButton = {
        $0.backgroundColor = .heroWhite100s
        return $0
    }(UIButton())
    
    private let friendCountView: CountContentView = {
        $0.title = "친구"
        $0.count = 19
        return $0
    }(CountContentView())
    
    private let bucketCountView: CountContentView = {
        $0.title = "버킷"
        $0.count = 27
        return $0
    }(CountContentView())
    
    private let awardCountView: CountContentView = {
        $0.title = "어워드"
        $0.count = 8
        return $0
    }(CountContentView())
    
    private let bucketButton: UIButton = {
        $0.backgroundColor = .heroWhite100s
        return $0
    }(UIButton())
    
    private let awardButton: UIButton = {
        $0.backgroundColor = .heroWhite100s
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = (contentView.frame.size.width - 2) / 3
        DebugLog("Count View - Content View Width : \(contentView.frame.size.width)")
        
        friendButton.snp.updateConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(width)
        }
        
        bucketButton.snp.updateConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(width)
        }
        
        awardButton.snp.updateConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        addSubview(contentView)
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(friendButton)
        contentStackView.addArrangedSubview(separator1)
        contentStackView.addArrangedSubview(bucketButton)
        contentStackView.addArrangedSubview(separator2)
        contentStackView.addArrangedSubview(awardButton)
        
        friendButton.addSubview(friendCountView)
        bucketButton.addSubview(bucketCountView)
        awardButton.addSubview(awardCountView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        friendCountView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        bucketCountView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        awardCountView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        separator1.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        separator2.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        layoutIfNeeded()
    }
}
