//
//  UIColor+Hero.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/02/21.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

public extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.deletingPrefix("#")
        hex = hex.deletingPrefix("0x")
        if hex.count != 6 {
            DebugLog("hex count is not length 6")
        }
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(red: CGFloat(red) / 0xff, green: CGFloat(green) / 0xff, blue: CGFloat(blue) / 0xff, alpha: alpha)
    }
    
    static func dynamicColor(_ light: UIColor, _ dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        }
        return light
    }
    
    static var heroBlue100s: UIColor { fetchHeroColor(#function) }
    
    static var heroWhite100s: UIColor { fetchHeroColor(#function) }
    static var heroBlack100s: UIColor { fetchHeroColor(#function) }
    
    static var heroGray000s: UIColor { fetchHeroColor(#function) }
    static var heroGray600s: UIColor { fetchHeroColor(#function) }
    
    private static func fetchHeroColor(_ name: String) -> UIColor {
        let name = name.replacingOccurrences(of: "hero", with: "").lowercased()
        let assetName = "hero_\(name)"
        guard let color = UIColor(named: assetName, in: Bundle.heroUI, compatibleWith: nil) else {
            //            assertionFailure()
            return .darkGray
        }
        return color
    }
}
