//
//  AuthService.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Alamofire
import Foundation
import HeroCommon
import RxSwift

public class AuthService {
    private var httpClient: BaseHTTPClient
    
    public init() {
        httpClient = BaseHTTPClient.instance
    }
    
    public func refreshAccessToken(refreshToken: String) -> Observable<(HTTPURLResponse, String)> {
        let apiRouteURL = "/\(HeroURLConsts.version)/auth/access-token"
        HeroLog.debug(apiRouteURL)
        
        return httpClient.requestGetJSON(.get, apiRouteURL, addHeader: ["refreshToken": refreshToken], parameter: [:])
    }
}
