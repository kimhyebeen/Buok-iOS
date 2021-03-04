//
//  UserAuthModel.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import ObjectMapper

class UserAuthModel: Mappable {
    var id: Int?
    var nickname: String?
    var thumbnail: String?
    var deleted: Bool?
    var roleFlag:Int?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        nickname <- map["nickname"]
        thumbnail <- map["thumbnail"]
        deleted <- map["deleted"]
        roleFlag <- map["roleFlag"]
    }
}
