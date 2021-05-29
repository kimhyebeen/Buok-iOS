//
//  HeroAPIError.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public enum ErrorCode: Int {
    // 이 값들은 실제 개발 시 수정되어야 하는 값들
//        case cancelled = -9999
//        case badResponse = -1
//        case serverError = -2
//        case urlError = -3
//        case unauthorizedNetwork = -4
//        case notConnectedToInternet = -5
//        case cannotConnectToHost = -6
//        case timedOut = -7
    
    case unauthorized = 401
    case forbidden = 402
    case notfound = 403
}

public struct HeroAPIError: Error {
	public let statusCode: Int
	public let errorCode: ErrorCode
	public init(errorCode: ErrorCode, statusCode: Int) {
		self.errorCode = errorCode
		self.statusCode = statusCode
	}
}
