//
//  UserUseCase.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Alamofire
import Foundation
import HeroCommon
import RxSwift

public class UserUseCase {
    private var userService: UserService
    private var authService: AuthService
    
    public init() {
        self.userService = UserService()
        self.authService = AuthService()
    }
    
    public func getUserDetailInfo(accessToken: String, userId: Int) -> Observable<(HTTPURLResponse, String)> {
        return userService.getUserDetailInfo(accessToken: accessToken, userId: userId)
        .subscribeOn(MainScheduler.asyncInstance)
        .observeOn(MainScheduler.instance)
            .do(onNext: {(response, jsonString) in
                let _ = UserResponse(JSONString: jsonString)
        })
    }
    
    public func getAccessToken(refreshToken: String) -> Observable<(HTTPURLResponse, String)> {
        return authService.refreshAccessToken(refreshToken: refreshToken)
        .subscribeOn(MainScheduler.asyncInstance)
        .observeOn(MainScheduler.instance)
        .do(onNext: {(response, jsonString) in
            let _ = TokenRefreshResponse(JSONString: jsonString)
        })
    }
}
