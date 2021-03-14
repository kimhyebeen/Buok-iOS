//
//  HeroHeader.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public enum HeroHeader {
    case authorization
    case heroAgent
    case accept(value: String)
    case contentType(value: String)
    case custom(key: String, value: String)
    
    var key: String {
        switch self {
        case .authorization:
            return "authorization"
        case .heroAgent:
            return "hero-agent"
        case .accept:
            return "Accept"
        case .contentType:
            return "Content-Type"
        case .custom(let key, _):
            return key
        }
    }
    
    // Need to be updated
    public var value: String {
        switch self {
        case .authorization:
            return "Authorization"
        case .heroAgent:
            return "ios/versionCode"
        case .accept(let value):
            return value
        case .contentType(let value):
            return value
        case .custom(_, let value):
            return value
        }
    }
}
