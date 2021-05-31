//
//  SplashViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/29.
//

import Foundation
import HeroCommon

final class SplashViewModel {
    var isValidToken: Dynamic<Bool> = Dynamic(false)
    
    private let coordinator: StartCoordinator
    
    init(coordinator: StartCoordinator) {
        self.coordinator = coordinator
    }
    
    func checkInitialLaunch() {
        if AppConfiguration.shared.isInitialLaunch {
            coordinator.setRootVCtoWorkThruVC()
        } else {
            DebugLog("Check Initial Launch")
            checkRefreshToken()
        }
    }
    
    func checkRefreshToken() {
        // RefreshToken으로 AccessToken 갱신 후 로그인으로 이동
        if AppConfiguration.shared.isInitialLaunch {
            let result = TokenManager.shared.deleteAllTokenData()
            DebugLog("Delete All Token Result : \(result)")
            AppConfiguration.shared.isInitialLaunch = false
            self.isValidToken.value = false
        } else {
            if let accessToken = TokenManager.shared.getAccessToken(),
               let refreshToken = TokenManager.shared.getRefreshToken() {
                if TokenManager.shared.checkAccessTokenExpired() {
                    if TokenManager.shared.checkRefreshTokenExpired() {
                        // RefreshToken 만료 : 로그인 화면으로 이동
                        isValidToken.value = false
                    } else {
                        refreshAccessToken(refreshToken: refreshToken)
                    }
                } else {
                    // AccessToken으로 자동 로그인
                    fetchUserInfo(accessToken: accessToken)
                }
            } else {
                isValidToken.value = false
            }
        }
    }
    
    // MARK: RefreshToken으로 AccessToken 재발급
    func refreshAccessToken(refreshToken: String) {
        self.isValidToken.value = false
    }
    
    // MARK: AccessToken으로 사용자 정보 갱신
    func fetchUserInfo(accessToken: String) {
        UserAPIRequest.getUserInfo(responseHandler: { result in
            switch result {
            case .success(let userData):
                DebugLog("사용자 정보: \(userData.nickname)\n\(userData.intro)\n\(userData.profileUrl ?? "")")
//                DebugLog("사용자 정보: \(userData.user.nickname)\n\(userData.user.intro)\n\(userData.user.profileUrl ?? "")")
                self.isValidToken.value = true
            case .failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
                self.isValidToken.value = false
            }
        })
    }
    
    func goToLoginVC() {
        coordinator.setRootVCtoLoginVC()
    }
    
    func goToHomeVC() {
        coordinator.setRootVCtoHomeVC()
    }
}
