//
//  HeroAPIError.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public struct HeroAPIError: Error {
    public enum ErrorCode: Int {
        // 이 값들은 실제 개발 시 수정되어야 하는 값들
        case cancelled = -9999
        case badResponse = -1
        case serverError = -2
        case urlError = -3
        case unauthorizedNetwork = -4
        case notConnectedToInternet = -5
        case cannotConnectToHost = -6
        case timedOut = -7
        
        case badRequest = 400
        case unauthorized = 401
        
        var isServerError: Bool {
            switch self {
            case .serverError:
                return true
            default:
                return false
            }
        }
    }
       
    public let statusCode: Int
    public var message: String?
    public let errorCode: ErrorCode
    public let rawError: Error
    public var rawData: [AnyHashable: Any]?
    
    public init(errorCode: ErrorCode, statusCode: Int, error: Error) {
        self.errorCode = errorCode
        self.statusCode = statusCode
        self.rawError = error
    }
}
