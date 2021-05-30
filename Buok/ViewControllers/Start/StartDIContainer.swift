//
//  StartDIContainer.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/29.
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
    
    func createLoginVC() -> LoginViewController {
        return LoginViewController()
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
