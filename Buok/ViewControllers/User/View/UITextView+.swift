//
//  UITextView+.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/10.
//

import HeroUI

extension UITextView {
    func numberOfLine() -> Int {
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font!.lineHeight)) - 1
    }
}
