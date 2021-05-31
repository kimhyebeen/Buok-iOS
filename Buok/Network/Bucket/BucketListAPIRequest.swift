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

// MARK: - Data
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

// MARK: - ServerModel
struct BucketListServerModel: Codable {
	var status: Int
	var message: String
	var data: BucketsData
}

public struct BucketListAPIRequest {
	enum BucketRequestType: APIRequestType {
		case bucketsList(state: Int, category: Int, sort: Int)
		case bucketsPost(bucket: [String: Any])
		case bucketsEdit(bucketId: Int, bucket: [String: Any])
		case bucketEditComplete(bucketId: Int)
		
		var requestURL: URL {
			switch self {
			case .bucketsList, .bucketsPost:
				return URL(string: HeroConstants.bucket)!
			case let .bucketsEdit(bucketId, _):
				return URL(string: HeroConstants.bucket + "/\(bucketId)")!
			case let .bucketEditComplete(bucketId):
				return URL(string: HeroConstants.bucket + "/\(bucketId)/complete")!
			}
		}
		
		var requestParameter: [String: Any]? {
			switch self {
			case let .bucketsList(state, category, sort):
				return ["state": state, "category": category, "sort": sort]
			case let .bucketEditComplete(bucketId):
				return ["bucketId": bucketId]
			case .bucketsPost, .bucketsEdit:
				return nil
			}
		}
		
		var httpMethod: HeroRequest.Method {
			switch self {
			case .bucketsList:
				return .get
			case .bucketsPost:
				return .post
			case .bucketsEdit, .bucketEditComplete:
				return .put
			}
		}
		
		var encoding: HeroRequest.RequestEncoding {
			switch self {
			case .bucketsList:
				return .urlQuery
			case .bucketsPost:
				return .json
			case .bucketsEdit, .bucketEditComplete:
				return .url
			}
		}
		
		var requestBody: [String: Any]? {
			switch self {
			case .bucketsList, .bucketEditComplete:
				return nil
			case let .bucketsPost(bucket), let .bucketsEdit(_, bucket):
				return bucket
			}
		}
	}
	
	static func bucketListRequest(state: Int, category: Int, sort: Int, responseHandler: @escaping (Result<BucketsData, HeroAPIError>) -> Void) {
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
	
	static func bucketPostRequest(bucket: Bucket, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> Void) {
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
					let getData = try JSONDecoder().decode(BaseServerModel.self, from: jsonData)
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
	
	static func editBucketInfo(bucketId: Int, bucket: Bucket, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> Void) {
		var bucketArray = [String: Any]()
		bucketArray["bucketName"] = bucket.bucketName
		bucketArray["categoryId"] = bucket.categoryId
		bucketArray["content"] = bucket.content
		bucketArray["endDate"] = bucket.endDate
		bucketArray["imageList"] = bucket.imageList
		bucketArray["startDate"] = bucket.startDate
		bucketArray["state"] = bucket.state
		bucketArray["tagList"] = bucket.tagList
		BaseAPIRequest.requestJSONResponse(requestType: BucketRequestType.bucketsEdit(bucketId: bucketId, bucket: bucketArray)).then { responseData in
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
				ErrorLog("BucketListAPIRequest ERROR")
			}
		}
	}
	
	static func completeEditBucket(bucketId: Int, responseHandler: @escaping (Result<Bool, HeroAPIError>) -> Void) {
		BaseAPIRequest.requestJSONResponse(requestType: BucketRequestType.bucketEditComplete(bucketId: bucketId)).then { responseData in
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
				ErrorLog("BucketListAPIRequest ERROR")
			}
		}
	}
}
