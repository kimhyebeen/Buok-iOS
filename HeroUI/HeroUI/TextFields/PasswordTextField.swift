//
//  PasswordTextField.swift
//  HeroUI
//
//  Created by 김혜빈 on 2021/04/13.
//

import UIKit

public class PasswordTextField: UITextField {

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
        self.isSecureTextEntry = true
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: self.frame.height))
        self.leftViewMode = .always
        // todo - 추후 눈 아이콘버튼 추가
    }
    
    public func setPlaceHolder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: UIFont.font22P])
    }

}
