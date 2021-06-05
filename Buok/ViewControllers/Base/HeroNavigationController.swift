//
//  HeroNavigationController.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

public class HeroNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    public override func viewDidLoad() {
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
