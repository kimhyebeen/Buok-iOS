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
        
        let loginVC = LoginViewController()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = loginVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
