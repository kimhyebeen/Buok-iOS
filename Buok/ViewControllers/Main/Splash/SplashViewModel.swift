//
//  SplashViewModel.swift
//  Buok
//
//  Created by denny on 2021/05/29.
//

import Foundation
import HeroCommon

final class SplashViewModel {
    var isValidToken: Dynamic<Bool> = Dynamic(false)
    
    private let coordinator: StartCoordinator
    
    init(coordinator: StartCoordinator) {
      self.coordinator = coordinator
    }
    
    func checkRefreshToken() {
        // RefreshToken으로 AccessToken 갱신 후 로그인으로 이동
        // TEMP
        isValidToken.value = true
    }
    
    func goToLoginVC() {
        coordinator.setRootVCtoHomeVC()
    }
    
    func goToHomeVC() {
        coordinator.setRootVCtoHomeVC()
    }
}
