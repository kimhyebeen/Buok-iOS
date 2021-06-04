//
//  EmailAuthAPIRequest.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/02.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

// MARK: - ServerModel
struct EmailAuthRequestServerModel: Codable {
    var status: Int
    var message: String
    var data: Data?
}

struct EmailAuthValidateServerModel: Codable {
    var status: Int
    var message: String
    var data: String
}

public struct EmailAuthAPIRequest {
    enum EmailAuthRequestType: APIRequestType {
        case requestAuthCode(email: String)
        case validateAuthCode(code: String)
        
        var requestURL: URL {
            switch self {
            case .requestAuthCode:
                return URL(string: HeroConstants.email + "/send")!
            case .validateAuthCode:
                return URL(string: HeroConstants.email + "/verify")!
            }
        }
        
        var requestHeaders: [HeroHeader]? {
            [.custom("Content-Type", "application/json")]
        }
        
        var requestParameter: [String: Any]? {
            switch self {
            case let .requestAuthCode(email):
                return ["email": email]
            case let .validateAuthCode(code):
                return ["code": code]
            }
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
        
        var imagesToUpload: [UIImage]? {
            nil
        }
    }
    
    static func requestAuthCode(email: String, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: EmailAuthRequestType.requestAuthCode(email: email)).then {
            responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
                    let getData = try JSONDecoder().decode(EmailAuthRequestServerModel.self, from: jsonData)
                    if getData.status < 300 {
                        responseHandler(.success(true))
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("Email Auth APIRequest ERROR")
                responseHandler(.failure(HeroAPIError(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
            }
        }
    }
    
    static func validateAuthCode(code: String, responseHandler: @escaping (Result<String, HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: EmailAuthRequestType.validateAuthCode(code: code)).then {
            responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
                    let getData = try JSONDecoder().decode(EmailAuthValidateServerModel.self, from: jsonData)
                    if getData.status < 300 {
                        responseHandler(.success(getData.data))
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("Email Auth APIRequest ERROR")
                responseHandler(.failure(HeroAPIError(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
            }
        }
    }
}
