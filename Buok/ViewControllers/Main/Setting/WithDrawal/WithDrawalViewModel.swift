//
//  WithDrawalViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroNetwork
import HeroUI

final class WithDrawalViewModel {
    func requestWithDrawal() {
        UserAPIRequest.deleteUser(responseHandler: { result in
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    self.goToLoginVC()
                } else {
                    ErrorLog("200 : 탈퇴 결과 - 실패")
                }
            case .failure(_):
                ErrorLog("탈퇴 에러가 발생하였습니다.")
            }
        })
    }
    
    func goToLoginVC() {
        let navController = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navController.viewControllers = [LoginViewController()]
        navController.isNavigationBarHidden = true
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
