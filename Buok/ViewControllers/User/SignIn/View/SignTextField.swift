//
//  SignTextField.swift
//  HeroUI
//
//  Created by 김혜빈 on 2021/04/13.
//

import UIKit

public class SignTextField: UITextField {
    let insetX: CGFloat = 16
    let insetY: CGFloat = 10

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
        self.font = .font22P
    }
    
    public func setPlaceHolder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: UIFont.font22P])
    }

}
