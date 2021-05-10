//
//  IntroduceTextField.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

class IntroduceTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupView(textContainer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(_ container: NSTextContainer?) {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.font = .font15P
        self.textColor = .heroGray5B
        
        container?.lineFragmentPadding = 0
        self.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
    }

}
