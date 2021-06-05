//
//  StartDIContainer.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class StartDIContainer {
    func createSplashVC(coordinator: StartCoordinator) -> SplashViewController {
        let viewModel = SplashViewModel(coordinator: coordinator)
        let splashVC = SplashViewController(viewModel: viewModel)
        return splashVC
    }
    
    func createLoginNavVC() -> HeroNavigationController {
        let navController = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navController.viewControllers = [LoginViewController()]
        navController.isNavigationBarHidden = true
        return navController
    }
    
    func createMainNavVC() -> HeroNavigationController {
        let navigationVC = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navigationVC.viewControllers = [MainTabBarViewController()]
        navigationVC.isNavigationBarHidden = true
        return navigationVC
    }
    
    func createWorkThruVC() -> WorkThruViewController {
        let workThruViewModel = WorkThruViewModel()
        let workThruVC = WorkThruViewController(viewModel: workThruViewModel)
        return workThruVC
    }
}
