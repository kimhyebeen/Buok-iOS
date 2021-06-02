//
//  HeroConstants.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public struct HeroConstants {
//    public static let base = "http://13.125.236.11:8080/api/v2"
    public static let base = "http://3.36.226.192:8080/api/v2"
	
	public static var token: String {
		return "/token"
	}
	
	public static var user: String {
		return "/users"
	}
    
    public static var email: String {
        return "/email"
    }
	
	public static var bucket: String {
		return "/buckets"
	}
    
    public static var search: String {
        return "/search"
    }
}
