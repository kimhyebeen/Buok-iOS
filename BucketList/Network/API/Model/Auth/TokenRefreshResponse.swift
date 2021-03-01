//
//  TokenRefreshResponse.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Foundation
import ObjectMapper

class TokenRefreshResponse: Mappable {
    var accessToken: AccessTokenModel?
    var message: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        accessToken <- map["accessToken"]
        message <- map["message"]
    }
}
