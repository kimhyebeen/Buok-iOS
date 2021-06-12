//
//  SearchAPIRequest.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

public enum SearchType: Int {
    case myBucket = 0
    case user = 1
    case mark = 2
    
    public func getString() -> String {
        switch self {
        case .myBucket:
            return "my"
        case .user:
            return "user"
        case .mark:
            return "mark"
        }
    }
}

struct SearchUserServerModel: Codable {
    var status: Int
    var message: String
    var data: [SearchUserModel]
}

struct SearchBucketServerModel: Codable {
    var status: Int
    var message: String
    var data: [SearchBucketModel]
}

struct SearchUserModel: Codable {
    var userId: Int
    var email: String?
    var nickname: String
    var intro: String?
    var profileUrl: String?
    var friendStatus: Int
}

struct SearchBucketModel: Codable {
    var id: Int
    var userId: Int?
    var bucketName: String
    var content: String
    var createdDate: String
    var endDate: String
    var bucketState: Int
    var categoryId: Int?
    var userProfileUrl: String?
    var fin: Bool
    var bookmark: Bool
}

public struct SearchAPIRequest {
    enum SearchRequestType: APIRequestType {
        case searchMyBucket(keyword: String)
        case searchUser(keyword: String)
        case searchBookmark(keyword: String)
        
        var requestURL: URL {
            switch self {
            case .searchMyBucket:
                return URL(string: HeroConstants.search)!
            case .searchUser:
                return URL(string: HeroConstants.search)!
            case .searchBookmark:
                return URL(string: HeroConstants.search)!
            }
        }
        
        var requestParameter: [String: Any]? {
            switch self {
            case let .searchMyBucket(keyword):
                return ["type": SearchType.myBucket.getString(), "keyword": keyword]
            case let .searchUser(keyword):
                return ["type": SearchType.user.getString(), "keyword": keyword]
            case let .searchBookmark(keyword):
                return ["type": SearchType.mark.getString(), "keyword": keyword]
            }
        }
        
        var httpMethod: HeroRequest.Method {
            switch self {
            case .searchMyBucket:
                return .get
            case .searchUser:
                return .get
            case .searchBookmark:
                return .get
            }
        }
        
        var encoding: HeroRequest.RequestEncoding {
            switch self {
            case .searchMyBucket:
                return .url
            case .searchUser:
                return .url
            case .searchBookmark:
                return .url
            }
        }
        
        var requestBody: [String: Any]? {
            nil
        }
        
        var imagesToUpload: [UIImage]? {
            nil
        }
    }
    
    static func searchMyBucketData(keyword: String, responseHandler: @escaping (Result<[SearchBucketModel], HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: SearchRequestType.searchMyBucket(keyword: keyword)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
                    let getData = try JSONDecoder().decode(SearchBucketServerModel.self, from: jsonData)
                    let bucketsData = getData.data
                    
                    if getData.status < 300 {
                        responseHandler(.success(bucketsData))
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("BucketListAPIRequest ERROR")
            }
        }
    }
    
    static func searchUserData(keyword: String, responseHandler: @escaping (Result<[SearchUserModel], HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: SearchRequestType.searchUser(keyword: keyword)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
                    let getData = try JSONDecoder().decode(SearchUserServerModel.self, from: jsonData)
					let usersData = getData.data
					
                    if getData.status < 300 {
						responseHandler(.success(usersData))
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("BucketListAPIRequest ERROR")
            }
        }
    }
}
