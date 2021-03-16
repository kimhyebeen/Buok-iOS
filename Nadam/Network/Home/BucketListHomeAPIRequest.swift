//
//  BucketListHomeAPIRequest.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

struct UserData: Codable {
    var id: Int64
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Codable {
    var url: String
    var text: String
}

struct BucketListNoticeServerModel: Codable {
    var data: UserData
    var support: Support
}

public struct BucketListAPIRequest {
    enum RequestType: APIRequestType {
        case noticeList
        
        var requestURL: URL {
            switch self {
            case .noticeList:
//                return APIConstant.homeURL.appendingPathComponent("v1").appendingPathComponent("4b303ea9")
                return URL(string: "2")!
            }
        }
        
        var requestParameter: [String: Any]? {
            nil
        }
        
        var httpMethod: HeroRequest.Method {
            switch self {
            default:
                return .get
            }
        }
        
        var encoding: HeroRequest.RequestEncoding {
            .json
        }
    }
    
    static func homeNoticeListRequest() {
        DebugLog("API 실행 전 -- HomeURL : \(APIConstant.homeURL)")
        BaseAPIRequest.requestJSONResponse(requestType: RequestType.noticeList).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(BucketListNoticeServerModel.self, from: jsonData)
                    DebugLog(">>>> HomeAPIRequest getData : \(getData.data.email), \(getData.data.firstName), \(getData.data.lastName)")
                }
            } catch {
                DebugLog(">>>> HomeAPIRequest ERROR")
            }
        }
    }
}
