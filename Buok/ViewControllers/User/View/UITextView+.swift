//
//  UITextView+.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

extension UITextView {
    func numberOfLine() -> Int {
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font!.lineHeight)) - 1
    }
}
