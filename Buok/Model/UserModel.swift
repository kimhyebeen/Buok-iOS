//
//  UserModel.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    var id: Int?
    var email: String?
    var nickname: String?
    var thumbnail: String?
    var deleted: Bool?
}
