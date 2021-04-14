//
//  SignTextField.swift
//  HeroUI
//
//  Created by 김혜빈 on 2021/04/13.
//

import UIKit

public class SignTextField: UITextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.font = .font22P
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: self.frame.height))
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: self.frame.height))
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
    
    public func setPlaceHolder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: UIFont.font22P])
    }

}
