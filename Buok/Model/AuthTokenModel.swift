//
//  AuthTokenModel.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

struct AccessTokenModel: Codable {
    var token: String?
    var expiresIn: Int?
}
