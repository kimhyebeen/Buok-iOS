//
//  BucketListHomeAPIRequest.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

struct BucketsListData: Codable {
	var id: Int
	var bucketName: String
	var startDate: String
	var endDate: String
	var bucketState: String
	var categoryName: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case bucketName
		case startDate
		case endDate
		case bucketState
		case categoryName
	}
}

struct BucketsData: Codable {
	var buckets: [BucketsListData]
	var bucketCount: Int
	
	enum CodingKeys: String, CodingKey {
		case buckets
		case bucketCount
	}
}

// MARK: - ServerModel
struct BucketListServerModel: Codable {
	var status: Int
	var message: String
	var data: BucketsData
}

public struct BucketListAPIRequest {
	enum BucketRequestType: APIRequestType {
		case bucketsList(bucketState: String, category: String, sort: String)
		case bucketsPost
		
		var requestURL: URL {
			URL(string: HeroConstants.bucket)!
		}
		
		var requestParameter: [String: Any]? {
			switch self {
			case let .bucketsList(bucketState, category, sort):
				return ["bucketState": bucketState, "category": category, "sort": sort]
			case .bucketsPost:
				return nil
			}
		}
		
		var httpMethod: HeroRequest.Method {
			switch self {
			case .bucketsList:
				return .get
			case .bucketsPost:
				return .post
			}
		}
		
		var encoding: HeroRequest.RequestEncoding {
			.json
		}
	}
	
	static func bucketListRequest(bucketState: String, category: String, sort: String) {
        BaseAPIRequest.requestJSONResponse(requestType: BucketRequestType.bucketsList(bucketState: bucketState, category: category, sort: sort)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(BucketListServerModel.self, from: jsonData)
					DebugLog(">>>> BucketListAPIRequest getData : \(getData.data.bucketCount), \(getData.data.buckets.first?.bucketName ?? ""), \(getData.data.buckets.first?.categoryName ?? "")")
                }
            } catch {
                DebugLog(">>>> BucketListAPIRequest ERROR")
            }
        }
    }
}
