//
//  KeywordResponse.swift
//  BucketList
//
//  Created by 김혜빈 on 2021/03/11.
//

import Foundation

struct KeywordResponse: Codable {
    let result: String
    let returnObject: KeywordReturn
    
    enum CodingKeys: String, CodingKey {
        case returnObject = "return_object"
        case result
    }
}

struct KeywordReturn: Codable {
    let question: String
    let keylists: [KeywordItem]
}

struct KeywordItem: Codable {
    let keyword: String
    let weight: Double
}
