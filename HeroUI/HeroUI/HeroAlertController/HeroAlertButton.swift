//
//  HeroAlertButton.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

public enum HeroAlertButtonType {
    case okay
    case cancel
    
    func getHeight() -> CGFloat {
        switch self {
        case .okay:
            return 52
        case .cancel:
            return 40
        }
    }
}

public class HeroAlertButton: UIButton {
    private let textLabel: UILabel = UILabel()
    
    public var title: String? {
        didSet {
            textLabel.text = title
        }
    }
    
    public var alertButtonType: HeroAlertButtonType = .okay {
        didSet {
            updateViewStyle()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMainLayout()
        updateViewStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainLayout() {
        addSubview(textLabel)
        layer.cornerRadius = alertButtonType.getHeight() / 2
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(alertButtonType.getHeight())
        }
    }
    
    private func updateViewStyle() {
        switch alertButtonType {
        case .okay:
            textLabel.font = .font16PBold
            textLabel.textColor = .heroWhite100s
            
            backgroundColor = .heroBlue100s
            
            snp.updateConstraints { make in
                make.height.equalTo(alertButtonType.getHeight())
            }
        case .cancel:
            textLabel.font = .font16P
            textLabel.textColor = .heroGray600s
            
            backgroundColor = .clear
            
            snp.updateConstraints { make in
                make.height.equalTo(alertButtonType.getHeight())
            }
        }
    }
}
