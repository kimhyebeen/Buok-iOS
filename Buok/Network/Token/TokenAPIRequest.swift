//
//  TokenAPIRequest.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/31.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

// MARK: - Data
struct TokenData: Codable {
    var accessToken: String
    var refreshToken: String
    var accessExpiredAt: String
    var refreshExpiredAt: String
}

// MARK: - ServerModel
struct TokenServerModel: Codable {
    var status: Int
    var message: String
    var data: TokenData?
}

public struct TokenAPIRequest {
    enum TokenRequestType: APIRequestType {
        case refreshToken
        
        var requestURL: URL {
            switch self {
            case .refreshToken:
                return URL(string: HeroConstants.token + "/refresh")!
            }
        }
        
        var imagesToUpload: [UIImage]? {
            nil
        }
        
        var requestHeaders: [HeroHeader]? {
            [.custom("refreshToken", TokenManager.shared.getRefreshToken() ?? "")]
        }
        
        var requestParameter: [String: Any]? {
            nil
        }
        
        var httpMethod: HeroRequest.Method {
            .post
        }
        
        var encoding: HeroRequest.RequestEncoding {
            .json
        }
        
        var requestBody: [String: Any]? {
            nil
        }
    }
    
    static func refreshTokenRequest(responseHandler: @escaping (Result<TokenData, HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: TokenRequestType.refreshToken).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(TokenServerModel.self, from: jsonData)
                    if getData.status < 300 {
                        if let tokenData = getData.data {
                            responseHandler(.success(tokenData))
                        } else {
                            responseHandler(.failure(.init(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
                        }
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("TokenAPIRequest ERROR")
            }
        }
    }
}
