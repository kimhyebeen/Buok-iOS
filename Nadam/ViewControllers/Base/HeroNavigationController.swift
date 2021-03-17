//
//  HeroNavigationController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/01.
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
