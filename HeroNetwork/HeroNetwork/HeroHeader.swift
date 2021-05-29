//
//  HeroHeader.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public enum HeroHeader {
	case token
	case accept
	case contentType
	
	var key: String {
		switch self {
		case .token:
			return "token"
		case .accept:
			return "accept"
		case .contentType:
			return "Content-Type"
		}
	}
	
	public var value: String {
		switch self {
		case .token:
			return HeroConstants.token
		case .accept:
			return "*/*"
		case .contentType:
			return "application/json"
		}
	}
}
