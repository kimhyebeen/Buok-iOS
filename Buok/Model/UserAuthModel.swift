//
//  UserAuthModel.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

struct UserAuthModel: Codable {
    var id: Int?
    var nickname: String?
    var thumbnail: String?
    var deleted: Bool?
    var authFlag: Int?
}
