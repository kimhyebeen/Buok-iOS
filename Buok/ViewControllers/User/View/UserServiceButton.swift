//
//  ServiceButton.swift
//  HeroUI
//
//  Created by 김혜빈 on 2021/04/13.
//

import UIKit

public class UserServiceButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .heroServiceNavy
        self.layer.cornerRadius = 8
    }
    
    public func setHeroTitle(_ text: String) {
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [.font: UIFont.font17P, .foregroundColor: UIColor.white]), for: .normal)
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [.font: UIFont.font17P, .foregroundColor: UIColor.white]), for: .disabled)
    }
    
    public func setHeroEnable(_ value: Bool) {
        self.isEnabled = value
        self.backgroundColor = value ? .heroServiceNavy : .heroGrayA6A4A1
    }

}
