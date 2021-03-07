//
//  TabBarActionButton.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
//

import Foundation
import UIKit

public class TabBarActionButton: UIButton {
    public var actionButtonSize = CGSize(width: 64, height: 64)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewProperties() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .heroBlue100s
        layer.cornerRadius = actionButtonSize.height / 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        imageView?.tintColor = .heroWhite100s
    }
}
