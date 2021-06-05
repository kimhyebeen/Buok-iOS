//
//  WorkThruViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class WorkThruViewModel {
    func goToLoginVC() {
        AppConfiguration.shared.isInitialLaunch = false
        
        let navController = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navController.viewControllers = [LoginViewController()]
        navController.isNavigationBarHidden = true
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
