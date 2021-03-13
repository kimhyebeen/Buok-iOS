//
//  KeywordRequest.swift
//  BucketList
//
//  Created by 김혜빈 on 2021/03/11.
//

import Foundation

struct KeywordRequestBody: Codable {
    var key: String = ""
    var serviceId: String = ""
    var argument: KeywordRequestArgument
}

struct KeywordRequestArgument: Codable {
    var question: String
}
