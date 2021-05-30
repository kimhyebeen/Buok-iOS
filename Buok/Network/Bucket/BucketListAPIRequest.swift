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
	var categoryId: Int
}

struct BucketsData: Codable {
	var buckets: [BucketsListData]
	var bucketCount: Int
}

struct Bucket: Codable {
	var bucketName: String
	var categoryId: Int
	var content: String
	var endDate: String
	var imageList: [String]?
	var startDate: String
	var state: Int
	var tagList: [String]?
}

struct BucketListServerModel: Codable {
	var status: Int
	var message: String
	var data: BucketsData
}

struct BucketPostServerModel: Codable {
	var status: Int
	var message: String
	var data: Data?
}

public struct BucketListAPIRequest {
	enum BucketRequestType: APIRequestType {
		case bucketsList(state: Int, category: Int, sort: Int)
		case bucketsPost(bucket: [String: Any])
		
		var requestURL: URL {
			URL(string: HeroConstants.bucket)!
		}
		
		var requestParameter: [String: Any]? {
			switch self {
			case let .bucketsList(state, category, sort):
				return ["state": state, "category": category, "sort": sort]
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
			switch self {
			case .bucketsList:
				return .urlQuery
			case .bucketsPost:
				return .json
			}
		}
		
		var requestBody: [String: Any]? {
			switch self {
			case .bucketsList:
				return nil
			case let .bucketsPost(bucket):
				return bucket
			}
		}
	}
	
	static func bucketListRequest(state: Int, category: Int, sort: Int, responseHandler: @escaping (Result<BucketsData, HeroAPIError>) -> ()) {
		BaseAPIRequest.requestJSONResponse(requestType: BucketRequestType.bucketsList(state: state, category: category, sort: sort)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(BucketListServerModel.self, from: jsonData)
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
	
	static func bucketPostRequest(bucket: Bucket, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> ()) {
		var bucketArray = [String: Any]()
		bucketArray["bucketName"] = bucket.bucketName
		bucketArray["categoryId"] = bucket.categoryId
		bucketArray["content"] = bucket.content
		bucketArray["endDate"] = bucket.endDate
		bucketArray["imageList"] = bucket.imageList
		bucketArray["startDate"] = bucket.startDate
		bucketArray["state"] = bucket.state
		bucketArray["tagList"] = bucket.tagList
		BaseAPIRequest.requestJSONResponse(requestType: BucketRequestType.bucketsPost(bucket: bucketArray)).then { responseData in
			do {
				if let dictData = responseData as? NSDictionary {
					let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
					let getData = try JSONDecoder().decode(BucketPostServerModel.self, from: jsonData)
					if getData.status < 300 {
						responseHandler(.success(true))
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
