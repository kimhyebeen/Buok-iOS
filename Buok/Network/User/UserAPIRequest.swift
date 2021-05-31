//
//  UserAPIRequest.swift
//  Buok
//
//  Created by 김보민 on 2021/05/24.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

// MARK: - Data
struct UserData: Codable {
	var id: Int
	var email: String
	var nickname: String
	var intro: String
	var profileUrl: String?
	var createdDate: String?
    var socialType: Int?
    var socialId: Int?
}

struct UsermeData: Codable {
	var user: UserData
	var friendCount: Int
	var bucketCount: Int
	var bookmark: BookmarkData
	var isFriend: Bool?
}

struct BookmarkData: Codable {
	var bookmarkList: [BookmarkListData]?
	var bookMarkCount: Int
}

struct BookmarkListData: Codable {
	var id: Int
	var bucketName: String
	var endDate: String
	var categoryId: Int
}

struct ProfileData: Codable {
	var intro: String
	var nickname: String
	var profileUrl: String
}

// MARK: - ServerModel
struct UserProfileServerModel: Codable {
	var status: Int
	var message: String
	var data: UserData
}

struct UserPageServerModel: Codable {
	var status: Int
	var message: String
	var data: UsermeData
}

public struct UserAPIRequest {
	enum UserRequestType: APIRequestType {
		case getUserPage(userId: Int)
		case getProfile
		case getMyPageInfo
		case changeProfile(profile: [String: Any])
		
		var requestURL: URL {
			switch self {
            case let .getUserPage(userId):
                return URL(string: HeroConstants.user + "/\(userId)")!
			case .getProfile, .changeProfile:
				return URL(string: HeroConstants.user)!
			case .getMyPageInfo:
				return URL(string: HeroConstants.user + "/me")!
			}
		}
        
		var requestParameter: [String: Any]? {
			nil
		}
		
		var httpMethod: HeroRequest.Method {
			switch self {
			case .getUserPage, .getProfile, .getMyPageInfo:
				return .get
			case .changeProfile:
				return .put
			}
		}
		
		var encoding: HeroRequest.RequestEncoding {
			switch self {
			case .getUserPage:
				return .url
			case .getProfile, .getMyPageInfo, .changeProfile:
				return .json
			}
		}
		
		var requestBody: [String: Any]? {
			switch self {
			case .getUserPage, .getProfile, .getMyPageInfo:
				return nil
			case let .changeProfile(profile):
				return profile
			}
		}
	}
	
    static func getUserInfo(responseHandler: @escaping (Result<UserData, HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getProfile).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    let getData = try JSONDecoder().decode(UserProfileServerModel.self, from: jsonData)
                    let userData = getData.data
                    if getData.status < 300 {
                        responseHandler(.success(userData))
                    } else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("ERROR Detected")
                responseHandler(.failure(HeroAPIError(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
            }
        }
    }
	
	static func getUserPageInfo(userId: Int, responseHandler: @escaping (Result<UsermeData, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getUserPage(userId: userId)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(UserPageServerModel.self, from: jsonData)
					let usermeData = getData.data
					if getData.status < 300 {
						responseHandler(.success(usermeData))
					} else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
					}
				}
			} catch {
                ErrorLog("ERROR Detected")
                responseHandler(.failure(HeroAPIError(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
			}
		}
	}
	
	static func getMyPageIngo(responseHandler: @escaping (Result<UsermeData, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getMyPageInfo).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(UserPageServerModel.self, from: jsonData)
					let usermeData = getData.data
					if getData.status < 300 {
						responseHandler(.success(usermeData))
					} else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
					}
				}
			} catch {
                ErrorLog("ERROR Detected")
                responseHandler(.failure(HeroAPIError(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
			}
		}
	}
	
	static func changeProfileInfo(profile: ProfileData, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> Void) {
		var profileArray = [String: Any]()
		profileArray["intro"] = profile.intro
		profileArray["nickname"] = profile.nickname
		profileArray["profileUrl"] = profile.profileUrl
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.changeProfile(profile: profileArray)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(BaseServerModel.self, from: jsonData)
					if getData.status < 300 {
						responseHandler(.success(true))
					} else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
					}
				}
			} catch {
				ErrorLog("ERROR Detected")
                responseHandler(.failure(HeroAPIError(errorCode: .unknown, statusCode: -1, errorMessage: "알 수 없는 오류")))
			}
		}
	}
}
