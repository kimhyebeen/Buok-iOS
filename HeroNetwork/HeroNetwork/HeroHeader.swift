//
//  HeroHeader.swift
//  BucketList
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

public enum HeroHeader {
	case token(String)
	case accept
	case contentType
    case custom(String, String)
	
	public var key: String {
		switch self {
		case .token:
			return "accessToken"
		case .accept:
			return "accept"
		case .contentType:
			return "Content-Type"
        case .custom(let key, _):
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
        case .custom(_, let value):
            return value
		}
	}
}
