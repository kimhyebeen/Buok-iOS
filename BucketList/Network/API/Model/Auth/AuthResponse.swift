//
//  AuthResponse.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Foundation
import ObjectMapper

public class AuthResponse: Mappable {
    var refreshToken: String?
    var accessToken: AccessTokenModel?
    var userInfo: UserAuthModel?
    var message: String?
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        accessToken <- map["accessToken"]
        message <- map["message"]
        refreshToken <- map["refreshToken"]
        userInfo <- map["userInfo"]
    }
}
