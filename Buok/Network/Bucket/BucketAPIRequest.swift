//
//  BucketAPIRequest.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroNetwork
import Promise

public struct BucketAPIRequest {
    enum BucketRequestType: APIRequestType {
        case bucketDetail(bucketId: Int)
        
        var requestURL: URL {
            switch self {
            case let .bucketDetail(bucketId):
                return URL(string: HeroConstants.bucket + "/\(bucketId)")!
            }
        }
        
        var requestParameter: [String: Any]? {
            switch self {
            case .bucketDetail:
                return nil
            }
        }
        
        var httpMethod: HeroRequest.Method {
            switch self {
            case .bucketDetail:
                return .get
            }
        }
        
        var encoding: HeroRequest.RequestEncoding {
            switch self {
            case .bucketDetail:
                return .urlQuery
            }
        }
        
        var requestBody: [String: Any]? {
            switch self {
            case .bucketDetail:
                return nil
            }
        }
        
        var imagesToUpload: [UIImage]? {
            nil
        }
    }
    
    static func requestBucketDetail(bucketId: Int, responseHandler: @escaping (Result<BucketDetailModel, HeroAPIError>) -> Void) {
        BaseAPIRequest.requestJSONResponse(requestType: BucketRequestType.bucketDetail(bucketId: bucketId)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
                    let getData = try JSONDecoder().decode(BucketDetailServerModel.self, from: jsonData)
                    let bucketDetailData = getData.data
                    if getData.status < 300 {
                        responseHandler(.success(bucketDetailData))
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("BucketAPIRequest ERROR")
            }
        }
    }
}
