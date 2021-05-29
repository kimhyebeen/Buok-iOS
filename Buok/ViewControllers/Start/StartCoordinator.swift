//
//  StartCoordinator.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/29.
//

import Foundation
import HeroCommon
import HeroUI

final class StartCoordinator {
    private let dependencies: StartDIContainer
    
    init(startDIContainer: StartDIContainer) {
        self.dependencies = startDIContainer
    }
    
    func setRootVCtoLoginVC() {
        let loginVC = dependencies.createLoginVC()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
    }
    
    func setRootVCtoHomeVC() {
        let mainVC = dependencies.createMainNavVC()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
}
