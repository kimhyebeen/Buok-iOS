//
//  HeroSharedAssetsBundle.swift
//  HeroSharedAssets
//
//  Created by Taein Kim on 2021/03/14.
//

import Foundation
import UIKit

public extension Bundle {
    class var heroShared: Bundle {
        return Bundle(identifier: "com.yiteam.HeroSharedAssets")!
    }
}

public extension UIImage {
    convenience init?(heroSharedNamed: String) {
        self.init(named: heroSharedNamed, in: Bundle.heroShared, compatibleWith: nil)
    }
}

public extension String {
    var templateImageShared: UIImage? {
        return UIImage(named: self, in: Bundle.heroShared, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }

    var namedImageShared: UIImage? {
        return UIImage(named: self, in: .heroShared, compatibleWith: nil)
    }
}
