//
//  HeroLocalizable.swift
//  HeroSharedAssets
//
//  Copyright © 2021 Buok. All rights reserved.
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
