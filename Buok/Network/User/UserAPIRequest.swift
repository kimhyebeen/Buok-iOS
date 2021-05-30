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
	var id: Int?
	var email: String?
	var nickname: String
	var intro: String
	var profileUrl: String?
	var createdDate: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case email
		case nickname
		case intro
		case profileUrl
		case createdDate
	}
}

struct UsermeData: Codable {
	var user: UserData
	var friendCount: Int
	var bucketCount: Int
	var bookmark: BookmarkData
	
	enum CodingKeys: String, CodingKey {
		case user
		case friendCount
		case bucketCount
		case bookmark
	}
}

struct BookmarkData: Codable {
	var bookmarkList: [BookmarkListData]?
	var bookMarkCount: Int
	
	enum CodingKeys: String, CodingKey {
		case bookmarkList
		case bookMarkCount
	}
}

struct BookmarkListData: Codable {
	var id: Int
	var bucketName: String
	var endDate: String
	var categoryName: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case bucketName
		case endDate
		case categoryName
	}
}

// MARK: - ServerModel
struct UserListServerModel: Codable {
	var status: Int
	var message: String
	var data: UserData
}

struct BookmarkListServerModel: Codable {
	var status: Int
	var message: String
	var data: UsermeData
}

public struct UserAPIRequest {
	enum UserRequestType: APIRequestType {
        case user
		case users
		case usersme
		
		var requestURL: URL {
			switch self {
            case .user:
                return URL(string: HeroConstants.user)!
			case .users:
				return URL(string: HeroConstants.user)!
			case .usersme:
				return URL(string: HeroConstants.user + HeroConstants.me)!
			}
		}
        
		var requestParameter: [String: Any]? {
			nil
		}
		
		var httpMethod: HeroRequest.Method {
			.get
		}
		
		var encoding: HeroRequest.RequestEncoding {
			.json
		}
		
		var requestBody: [String: Any]? {
			nil
		}
	}
	
    static func getUserInfo(responseHandler: @escaping (Result<UserData, HeroAPIError>) -> ()) {
        BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.users).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(UserListServerModel.self, from: jsonData)
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
    
	static func usersListRequest() {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.users).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(UserListServerModel.self, from: jsonData)
					DebugLog(">>>> UserAPIRequest - usersListRequest getData: \(getData.status), \(getData.message)")
					DebugLog(">>>> UserAPIRequest - usersListRequest getData: \(getData.data.nickname), \(getData.data.intro), \(getData.data.profileUrl ?? "")")
				}
			} catch {
				DebugLog(">>>> UserAPIRequest ERROR")
			}
		}
	}
	
	static func usersmeListRequest() {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.usersme).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(BookmarkListServerModel.self, from: jsonData)
					DebugLog(">>>> UserAPIRequest - getData: \(getData.status), \(getData.message)")
					DebugLog(">>>> UserAPIRequest - getData: \(getData.data.user.nickname)")
					DebugLog(">>>> UserAPIRequest - getData: \(getData.data.friendCount), \(getData.data.bucketCount)")
                    DebugLog(">>>> UserAPIRequest - getData: \(getData.data.bookmark.bookMarkCount), \(getData.data.bookmark.bookmarkList?.first?.bucketName ?? "")")
				}
			} catch {
				DebugLog(">>>> UserAPIRequest ERROR")
			}
		}
	}
}
