//
//  SignAPIRequest.swift
//  Buok
//
//  Created by 김보민 on 2021/05/24.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

struct SignInData: Codable {
    var accessToken: String
	var refreshToken: String
	var accessExpiredAt: String
	var refreshExpiredAt: String
}

// MARK: - ServerModel
struct SignUpServerModel: Codable {
    var status: Int
    var message: String
    var data: Data?
}

struct SignInServerModel: Codable {
    var status: Int
    var message: String
    var data: SignInData
}

public struct SignAPIRequest {
    enum SignRequestType: APIRequestType {
        case signIn(email: String, password: String)
        case signUp(email: String, intro: String, nickname: String, password: String)
        
        var requestURL: URL {
            switch self {
            case .signIn:
                return URL(string: HeroConstants.user + "/signin")!
            case .signUp:
                return URL(string: HeroConstants.user + "/signup")!
            }
        }
        
        var requestParameter: [String: Any]? {
            switch self {
            case let .signIn(email, password):
                return ["email": email, "password": password]
            case let .signUp(email, intro, nickname, password):
                return ["email": email, "intro": intro, "nickname": nickname, "password": password]
            }
        }
        
        var httpMethod: HeroRequest.Method {
            .post
        }
        
        var encoding: HeroRequest.RequestEncoding {
            .json
        }
    }
    
    static func signInRequest(email: String, password: String, _ completion: @escaping (SignInData) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: SignRequestType.signIn(email: email, password: password)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(SignInServerModel.self, from: jsonData)
					completion(getData.data)
                }
            } catch {
                DebugLog(">>>> SignAPIRequest ERROR")
            }
        }
    }
    
    static func signUpRequest(email: String, intro: String, nickname: String, password: String, _ completion: @escaping (Int) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: SignRequestType.signUp(email: email, intro: intro, nickname: nickname, password: password)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(SignUpServerModel.self, from: jsonData)
					completion(getData.status)
                }
            } catch {
                DebugLog(">>>> SignAPIRequest ERROR")
            }
        }
    }
    
}
