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

struct UserData: Codable {
	var id: Int
	var email: String
	var nickname: String
	var intro: String
	var profileUrl: String?
	var createdDate: String?
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
		case getUserprofile
		case getMyPage
		
		var requestURL: URL {
			switch self {
            case let .getUserPage(userId):
                return URL(string: HeroConstants.user + "/\(userId)")!
			case .getUserprofile:
				return URL(string: HeroConstants.user)!
			case .getMyPage:
				return URL(string: HeroConstants.user + "me")!
			}
		}
        
		var requestParameter: [String: Any]? {
			nil
		}
		
		var httpMethod: HeroRequest.Method {
			.get
		}
		
		var encoding: HeroRequest.RequestEncoding {
			switch self {
			case .getUserPage:
				return .url
			case .getUserprofile, .getMyPage:
				return .json
			}
		}
		
		var requestBody: [String: Any]? {
			nil
		}
	}
	
    static func getUserInfo(responseHandler: @escaping (Result<UserData, HeroAPIError>) -> ()) {
        BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getUserprofile).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(UserProfileServerModel.self, from: jsonData)
                    let userData = getData.data
                    if getData.status < 300 {
                        responseHandler(.success(userData))
                    } else {
						responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("UserAPIRequest ERROR")
            }
        }
    }
	
	static func getUserPageInfo(userId: Int, responseHandler: @escaping (Result<UsermeData, HeroAPIError>) -> ()) {
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
				ErrorLog("UserAPIRequest ERROR")
			}
		}
	}
	
	static func getMyPageIngo(responseHandler: @escaping (Result<UsermeData, HeroAPIError>) -> ()) {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getMyPage).then { responseData in
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
				ErrorLog("UserAPIRequest ERROR")
			}
		}
	}
}
