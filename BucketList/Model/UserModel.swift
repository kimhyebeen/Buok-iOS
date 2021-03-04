//
//  UserModel.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import ObjectMapper

class UserModel: Mappable {
    var id: Int?
    var email: String?
    var nickname: String?
    var thumbnail: String?
    var deleted: Bool?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id        <- map["id"]
        email     <- map["email"]
        nickname  <- map["nickname"]
        thumbnail <- map["thumbnail"]
        deleted   <- map["deleted"]
    }
}
