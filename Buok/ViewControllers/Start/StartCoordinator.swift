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
}
