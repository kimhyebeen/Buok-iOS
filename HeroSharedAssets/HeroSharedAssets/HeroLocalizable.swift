//
//  HeroLocalizable.swift
//  HeroSharedAssets
//
//  Created by Taein Kim on 2021/03/14.
//

import Foundation

public extension String {
    var localized: String {
        if self.hasPrefix("Hero") {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.heroShared, comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    func localized(comment: String) -> String {
        if self.hasPrefix("Hero") {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.heroShared, comment: comment)
        } else {
            return NSLocalizedString(self, comment: comment)
        }
    }
}
