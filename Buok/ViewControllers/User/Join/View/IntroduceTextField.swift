//
//  IntroduceTextField.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

class IntroduceTextField: UITextField {
    let insetX: CGFloat = 16
    let insetY: CGFloat = 16

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.font = .font16P
        self.contentVerticalAlignment = .top
    }
    
    public func setPlaceHolder(_ text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: UIFont.font16P])
    }

}
