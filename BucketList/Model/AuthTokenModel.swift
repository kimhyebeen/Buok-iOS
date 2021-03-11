//
//  AuthTokenModel.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation

struct AccessTokenModel: Codable {
    var token: String?
    var expiresIn: Int?
}
