//
//  SettingSectionHeaderView.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/11.
//

import Foundation
import HeroCommon
import HeroUI

final class SettingSectionHeaderView: UIView {
    private let contentView: UIView = {
        $0.backgroundColor = .heroWhite100s
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(16)
        }
    }
}
