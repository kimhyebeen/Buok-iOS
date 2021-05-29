//
//  HeroHeader.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public enum HeroHeader {
	case token(String)
	case accept
	case contentType
    case custom(String)
	
	var key: String {
		switch self {
		case .token:
			return "token"
		case .accept:
			return "accept"
		case .contentType:
			return "Content-Type"
        case .custom(let key):
            return key
		}
	}
	
	public var value: String {
		switch self {
		case .token(let value):
			return value
		case .accept:
			return "*/*"
		case .contentType:
			return "application/json"
        case .custom(let value):
            return value
		}
	}
}
