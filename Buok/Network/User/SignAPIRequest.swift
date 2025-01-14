//
//  SignAPIRequest.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

// MARK: - Data
struct SignInData: Codable {
    var accessToken: String
	var refreshToken: String
	var accessExpiredAt: String
	var refreshExpiredAt: String
}

// MARK: - ServerModel
struct SignInServerModel: Codable {
    var status: Int
    var message: String
    var data: SignInData?
}

public struct SignAPIRequest {
    enum SignRequestType: APIRequestType {
        case signIn(email: String, password: String)
		case signUp(deviceToken: String, email: String, intro: String, nickname: String, password: String)
		case snsSignUp(deviceToken: String, socialType: String, email: String, socialId: String)
        
        var requestURL: URL {
            switch self {
            case .signIn:
                return URL(string: HeroConstants.user + "/signin")!
            case .signUp:
                return URL(string: HeroConstants.user + "/signup")!
			case let .snsSignUp(_, socialType, _, _):
				return URL(string: HeroConstants.social + "/\(socialType)")!
            }
        }
        
        var requestParameter: [String: Any]? {
            switch self {
            case let .signIn(email, password):
                return ["email": email, "password": password]
            case let .signUp(deviceToken, email, intro, nickname, password):
				return ["deviceToken": deviceToken, "email": email, "intro": intro, "nickname": nickname, "password": password]
			case .snsSignUp:
				return nil
            }
        }
        
        var httpMethod: HeroRequest.Method {
            .post
        }
        
        var encoding: HeroRequest.RequestEncoding {
			switch self {
			case .signIn, .signUp:
				return .json
			case .snsSignUp:
				return .url
			}
        }
		
		var requestBody: [String: Any]? {
			switch self {
			case .signIn, .signUp:
				return nil
			case let .snsSignUp(deviceToken, _, email, socialId):
				return ["deviceToken": deviceToken, "email": email, "socialId": socialId]
			}
		}
        
        var imagesToUpload: [UIImage]? {
            nil
        }
    }
    
	static func signInRequest(email: String, password: String, responseHandler: @escaping (Result<SignInData, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: SignRequestType.signIn(email: email, password: password)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
					let getData = try JSONDecoder().decode(SignInServerModel.self, from: jsonData)
					if getData.status < 300, let signInData = getData.data {
						responseHandler(.success(signInData))
					} else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
					}
				}
			} catch {
				ErrorLog("SignAPIRequest ERROR")
			}
		}
	}
    
	static func signUpRequest(deviceToken: String, email: String, intro: String, nickname: String, password: String, responseHandler: @escaping (Result<SignInData, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: SignRequestType.signUp(deviceToken: deviceToken, email: email, intro: intro, nickname: nickname, password: password)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
					let getData = try JSONDecoder().decode(SignInServerModel.self, from: jsonData)
					if getData.status < 300, let signInData = getData.data {
						responseHandler(.success(signInData))
					} else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
					}
				}
			} catch {
				ErrorLog("SignAPIRequest ERROR")
			}
		}
	}
	
	static func snsSignUpRequest(deviceToken: String, socialType: String, email: String, socialId: String, responseHandler: @escaping (Result<SignInServerModel, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: SignRequestType.snsSignUp(deviceToken: deviceToken, socialType: socialType, email: email, socialId: socialId) ).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					DebugLog("responseData : \(dictData)")
					DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
					
					let getData = try JSONDecoder().decode(SignInServerModel.self, from: jsonData)
					if getData.status < 300 {
						responseHandler(.success(getData))
					} else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
					}
				}
			} catch {
				ErrorLog("SignAPIRequest ERROR")
			}
		}
	}
}
