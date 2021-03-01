//
//  AuthTokenModel.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Foundation
import ObjectMapper

class AccessTokenModel: Mappable {
    var token: String?
    var expiresIn: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        expiresIn <- map["expiresIn"]
    }
}
