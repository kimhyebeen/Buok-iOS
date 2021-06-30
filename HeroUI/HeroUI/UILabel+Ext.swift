//
//  UILabel+Ext.swift
//  HeroUI
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    @objc
    func setAttributedText(_ title: String?, targetText: String?, attributes: [NSAttributedString.Key: Any]?) {
        guard let title = title, let targetText = targetText, let attributes = attributes else {
            return
        }

        let mutableString = NSMutableAttributedString(string: title)
        guard let regex = try? NSRegularExpression(pattern: targetText, options: [.caseInsensitive, .ignoreMetacharacters]) else {
            return
        }

        let matches = regex.matches(in: title, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: (title as NSString).length)) as [NSTextCheckingResult]

        if matches.count > 0 {
            for match in matches {
                mutableString.addAttributes(attributes, range: match.range)
            }
        } else {
            if let atFirstRange = title.range(of: targetText) {
                mutableString.addAttributes(attributes, range: NSRange(atFirstRange, in: targetText))
            }
        }

        attributedText = mutableString
    }
}
