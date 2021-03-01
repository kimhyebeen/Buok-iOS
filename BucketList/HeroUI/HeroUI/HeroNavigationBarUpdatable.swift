//
//  HeroNavigationBarUpdatable.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import HeroCommon

public protocol HeroNavigationBarUpdatable {
    func refreshShadowLine(offset: CGFloat)
}

public extension HeroNavigationBarUpdatable where Self: UIViewController {
    func refreshShadowLine(offset: CGFloat) {
        if let navigationBar = navigationController?.navigationBar as? HeroUINavigationBar {
            navigationBar.barTintColor = .white
            navigationBar.tintColor = .heroBlue100s
            
            if offset > 0 {
                navigationBar.setDefaultShadowImage()
            } else {
                navigationBar.removeDefaultShadowImage()
            }
        }
    }
}
