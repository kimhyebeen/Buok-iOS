//
//  StartCoordinator.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
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
        let loginVC = dependencies.createLoginNavVC()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = loginVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func setRootVCtoHomeVC() {
        let mainVC = dependencies.createMainNavVC()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = mainVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func setRootVCtoWorkThruVC() {
        let workThruVC = dependencies.createWorkThruVC()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = workThruVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
