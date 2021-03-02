//
//  UserResponse.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Foundation
import ObjectMapper

public class UserResponse: Mappable {
    var userInfo: UserModel?
    var message: String?
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        userInfo <- map["userInfo"]
        message <- map["message"]
    }
}
