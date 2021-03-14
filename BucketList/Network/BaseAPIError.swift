//
//  BaseAPIError.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Alamofire
import Foundation
import HeroCommon
import HeroNetwork

public enum BaseAPIError: Error {
    case heroAPIError(HeroAPIError)
    case parameterEncodingFailed
    case unknown
    case urlRequestError
    case tokenExpired(String)
    // 추가 가능
    
    public var errorMessage: String? {
        let message: String?
        switch self {
        case let.heroAPIError(error):
            let errorCode = error.errorCode
            if errorCode == .notConnectedToInternet || errorCode == .timedOut || errorCode == .cannotConnectToHost {
                message = "Error_Message_NetworkError"
            } else {
                message = error.message ?? "Network_ErrorMessage"
            }
        case let .tokenExpired(errorMessage):
            message = errorMessage
        default:
            message = nil
        }
        return message
    }
    
    public init(error: Error?) {
        if let error = error as? HeroAPIError {
            self = .heroAPIError(error)
        } else {
            self = .unknown
        }
    }
    
    public var isTokenExpired: Bool {
        if case .tokenExpired = self {
            return true
        }
        return false
    }
    
    public var isNetworkConnectionError: Bool {
        if case let .heroAPIError(brewAPIError) = self {
            let errorCode = brewAPIError.errorCode
            if errorCode == .unauthorizedNetwork || errorCode == .notConnectedToInternet || errorCode == .timedOut || errorCode == .cannotConnectToHost {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
        
    public var isServerError: Bool {
        switch self {
        case let .heroAPIError(heroAPIError):
            return heroAPIError.errorCode == .serverError
        default:
            return false
        }
    }
    
    public var isNotExist: Bool {
        return statusCode == 404
    }
    
    public var statusCode: Int {
        switch self {
        case let .heroAPIError(heroAPIError):
            return heroAPIError.statusCode
        default:
            return 520 // unknown
        }
    }
}
