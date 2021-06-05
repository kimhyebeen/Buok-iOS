//
//  SignTextField.swift
//  HeroUI
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

public class UserTextField: UITextField {
    let insetX: CGFloat = 16
    let insetY: CGFloat = 10
    var textFont: UIFont = .font22P {
        didSet {
            self.font = textFont
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.textColor = .heroGray5B
        self.font = textFont
    }
    
    public func setPlaceHolder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: textFont, .foregroundColor: UIColor.heroGrayDA])
    }

}
