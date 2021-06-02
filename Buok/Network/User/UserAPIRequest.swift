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

struct MyPageUserData: Codable {
	var user: UserData
	var friendCount: Int
	var bucketCount: Int
	var bookmark: BookmarkData
	var isFriend: Bool?
    
    func debugDescription() -> String {
        var message: String = ""
        message += "[UserData]\nEmail : \(user.email)\nNickname : \(user.nickname)\n"
        message += "Intro : \(user.intro)\nId : \(user.id)\nProfileURL : \(String(describing: user.profileUrl))\nCreatedDate : \(String(describing: user.createdDate))\n"
        message += "SocialType : \(String(describing: user.socialType))\nSocialId : \(String(describing: user.socialId))\n"

        message += "FriendCount : \(friendCount), BucketCount : \(bucketCount)\n"
        message += "isFriend : \(String(describing: isFriend))\n"
        message += "[BookmarkData]\nBookmarkCount : \(bookmark.bookMarkCount)\n"
        if let list = bookmark.bookmarkList {
            for item in list {
                message += "BucketName : \(item.bucketName)\nId : \(item.id)\nEndDate : \(item.endDate)\nCategoryId : \(item.categoryId)\n"
            }
        }
        
        return message
    }
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

struct MyPageUserServerModel: Codable {
	var status: Int
	var message: String
	var data: MyPageUserData
}

public struct UserAPIRequest {
	enum UserRequestType: APIRequestType {
		case getUserPage(userId: Int)
		case getProfile
		case getMyPageInfo
		case changeProfile(profile: [String: Any])
        case resetPassword(newPassword: String)
		
		var requestURL: URL {
			switch self {
            case let .getUserPage(userId):
                return URL(string: HeroConstants.user + "/\(userId)")!
			case .getProfile, .changeProfile:
				return URL(string: HeroConstants.user)!
			case .getMyPageInfo:
				return URL(string: HeroConstants.user + "/me")!
            case .resetPassword:
                return URL(string: HeroConstants.user + "/password")!
			}
		}
        
        var requestHeaders: [HeroHeader]? {
            switch self {
            case .resetPassword:
                return [.token(TokenManager.shared.getPasswordResetToken() ?? ""), .contentType]
            default:
                return [.token(TokenManager.shared.getAccessToken() ?? ""), .contentType]
            }
        }
        
		var requestParameter: [String: Any]? {
            switch self {
            case let .resetPassword(password):
                return ["password": password]
            default:
                return nil
            }
		}
		
		var httpMethod: HeroRequest.Method {
			switch self {
			case .getUserPage, .getProfile, .getMyPageInfo:
				return .get
            case .changeProfile, .resetPassword:
				return .put
			}
		}
		
		var encoding: HeroRequest.RequestEncoding {
			switch self {
			case .getUserPage:
				return .url
            case .getProfile, .getMyPageInfo, .changeProfile, .resetPassword:
				return .json
			}
		}
		
		var requestBody: [String: Any]? {
			switch self {
            case .getUserPage, .getProfile, .getMyPageInfo, .resetPassword:
				return nil
			case let .changeProfile(profile):
				return profile
			}
		}
	}
    
    static func resetPassword(newPassword: String, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.resetPassword(newPassword: newPassword)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
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
	
	static func getUserPageInfo(userId: Int, responseHandler: @escaping (Result<MyPageUserData, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getUserPage(userId: userId)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(MyPageUserServerModel.self, from: jsonData)
					let myPageUserData = getData.data
					if getData.status < 300 {
						responseHandler(.success(myPageUserData))
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
	
	static func getMyPageIngo(responseHandler: @escaping (Result<MyPageUserData, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: UserRequestType.getMyPageInfo).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
					let getData = try JSONDecoder().decode(MyPageUserServerModel.self, from: jsonData)
					let myPageUserData = getData.data
					if getData.status < 300 {
						responseHandler(.success(myPageUserData))
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
