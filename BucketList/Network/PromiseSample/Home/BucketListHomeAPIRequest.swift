//
//  BucketListHomeAPIRequest.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation
import HeroCommon
import Promise

struct UserData: Codable {
    var id: Int64
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    enum CodingKeys : String, CodingKey {
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
            .url
        }
    }
    
    static func homeNoticeListRequest() {
        print("API 실행 전 -- HomeURL : \(APIConstant.homeURL)")
        BaseAPIRequest().requestJSONResponse(requestType: RequestType.noticeList).then { responseData in
//            HeroLog.debug(">>>> ")
            print(">>>> HomeAPIRequest responseData : \(responseData.debugDescription)")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseData as? NSDictionary, options: .prettyPrinted)
                let getData = try JSONDecoder().decode(BucketListNoticeServerModel.self, from: jsonData)
                print(">>>> HomeAPIRequest getData : \(getData)")
            } catch {
                print(">>>> HomeAPIRequest ERROR")
            }
        }
    }
}
