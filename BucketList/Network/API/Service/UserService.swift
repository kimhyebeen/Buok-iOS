//
//  UserService.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Alamofire
import Foundation
import HeroCommon
import RxSwift

public class UserService {
    private var httpClient: BaseHTTPClient
    
    public init() {
        httpClient = BaseHTTPClient.instance
    }
    
    public func getUserDetailInfo(accessToken: String, userId: Int) -> Observable<(HTTPURLResponse, String)> {
        let apiRouteURL = "/\(HeroURLConsts.version)/users/\(userId)/detail"
        return httpClient.requestJSON(.get, apiRouteURL, addHeader: ["accessToken": accessToken], parameter: [:])
    }
}
