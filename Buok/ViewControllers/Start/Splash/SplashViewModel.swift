//
//  SplashViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
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
                DebugLog("AccessToken : \(accessToken)")
                DebugLog("RefreshToken : \(refreshToken)")
                
                DebugLog("AccessToken Expired : \(TokenManager.shared.checkAccessTokenExpired())")
                DebugLog("RefreshToken Expired : \(TokenManager.shared.checkRefreshTokenExpired())")
                
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
        TokenAPIRequest.refreshTokenRequest(responseHandler: { result in
            switch result {
            case .success(let tokenData):
                if TokenManager.shared.deleteAllTokenData() {
                    let sat = TokenManager.shared.setAccessToken(token: tokenData.accessToken)
                    let srt = TokenManager.shared.setRefreshToken(token: tokenData.accessToken)
                    let sated = TokenManager.shared.setAccessTokenExpiredDate(expiredAt: tokenData.accessExpiredAt.convertToDate())
                    let srted = TokenManager.shared.setRefreshTokenExpiredDate(expiredAt: tokenData.refreshExpiredAt.convertToDate())
                    DebugLog("sat : \(sat), srt : \(srt), sated : \(sated), srted : \(srted)")
                    
                    if sat && srt && sated && srted {
                        self.fetchUserInfo(accessToken: tokenData.accessToken)
                    } else {
                        self.isValidToken.value = false
                    }
                } else {
                    self.isValidToken.value = false
                }
            case .failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
                self.isValidToken.value = false
            }
        })
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
