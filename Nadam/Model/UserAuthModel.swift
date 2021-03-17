//
//  UserAuthModel.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation

struct UserAuthModel: Codable {
    var id: Int?
    var nickname: String?
    var thumbnail: String?
    var deleted: Bool?
    var authFlag: Int?
}
