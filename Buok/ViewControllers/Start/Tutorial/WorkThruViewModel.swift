//
//  WorkThruViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/30.
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
