//
//  HeroConstants.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public struct HeroConstants {
    #if SANDBOX
    public static let base = "http://13.125.236.11:8080/api/v2"
    #elseif INHOUSE
    public static let base = "http://13.125.236.11:8080/api/v2"
    #elseif REAL
    public static let base = "http://13.125.236.11:8080/api/v2"
    #else
    public static let base = "http://13.125.236.11:8080/api/v2"
    #endif
	
	public static var token: String {
		return "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNjIyMDE2NTI5fQ.ev-E1Ndtp2e0dp_6UeYdF7Fye2B3DHaa4JVxre86OF4"
	}
	
	public static var user: String {
		return "/users"
	}
	
	public static var bucket: String {
		return "/buckets"
	}
	
	public static var me: String {
		return "/me"
	}
}
