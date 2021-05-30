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
                self.isValidToken.value = true
            case .failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
                self.isValidToken.value = false
            }
        })
    }
    
    func goToLoginVC() {
        testFunction()
        coordinator.setRootVCtoLoginVC()
    }
    
    func goToHomeVC() {
        coordinator.setRootVCtoHomeVC()
    }
    
    // MARK: Test 지워야 함
    private func testFunction() {
		let accessResult = TokenManager.shared.setAccessToken(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMiIsImV4cCI6MTYyNDA2NjE2NX0.s3udBmY0_NGz1d2P_HR0OedOzaDoCNuuF16OEyuRjng")
        let refreshResult = TokenManager.shared.setRefreshToken(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMiIsImV4cCI6MTYyNDg1ODE2NX0.XKbMinwkmo7MeJId5FVawo8qiS4Csk1LoCQBd0N5-yk")
        
        let accessExpiredAtResult = TokenManager.shared.setAccessTokenExpiredDate(expiredAt: "2021-06-19 10:29:25".convertToDate())
        let refreshExpiredAtResult = TokenManager.shared.setRefreshTokenExpiredDate(expiredAt: "2021-06-28 14:29:25".convertToDate())
        
        DebugLog("Set Access Token Result : \(accessResult)")
        DebugLog("Set Refresh Token Result : \(refreshResult)")
        DebugLog("--------")
        
        DebugLog("Set Access Token ExpiredAt Result : \(accessExpiredAtResult)")
        DebugLog("Set Refresh Token ExpiredAt Result : \(refreshExpiredAtResult)")
        DebugLog("--------")
        
        DebugLog("Get Access Token Result : \(TokenManager.shared.getAccessToken() ?? "nil")")
        DebugLog("Get Refresh Token Result : \(TokenManager.shared.getRefreshToken() ?? "nil")")
        
        DebugLog("AccessToken Expired : \(TokenManager.shared.checkAccessTokenExpired())")
        DebugLog("RefreshToken Expired : \(TokenManager.shared.checkRefreshTokenExpired())")
    }
}
