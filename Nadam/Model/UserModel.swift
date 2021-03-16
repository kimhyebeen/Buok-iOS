//
//  UserModel.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation

struct UserModel: Codable {
    var id: Int?
    var email: String?
    var nickname: String?
    var thumbnail: String?
    var deleted: Bool?
}
