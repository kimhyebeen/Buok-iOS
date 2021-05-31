//
//  BaseAPIRequest.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/03.
//

import Alamofire
import Foundation
import HeroCommon
import HeroNetwork
import Promise
import SwiftyJSON

struct BaseServerModel: Codable {
    var status: Int
    var message: String
    var data: Data?
}

protocol APIRequestType {
    var requestURL: URL { get }
    var requestParameter: [String: Any]? { get }
    var httpMethod: HeroRequest.Method { get }
    var encoding: HeroRequest.RequestEncoding { get }
    var requestHeaders: [HeroHeader]? { get }
    var requestBody: [String: Any]? { get }
}

extension APIRequestType {
    var requestHeaders: [HeroHeader]? {
        [.token(TokenManager.shared.getAccessToken() ?? ""), .accept, .contentType]
    }
}

public class BaseAPIRequest {
    //	typealias RequestType = APIRequestType
    
    static func requestJSONResponse(requestType: APIRequestType) -> Promise<Any?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
            }
            
            if let requestBodyBucket = requestType.requestBody {
                heroRequest.requestBody = requestBodyBucket
            }
            
            AF.request(heroRequest).responseJSON { response in
                switch response.result {
                case .success(let value):
                    fulfill(value)
                case .failure(let error):
                    //                    if response.error != nil {
                    reject(BaseAPIError(error: error))
                //                    }
                }
            }
        }
    }
    
    static func requestStringResponse(requestType: APIRequestType) -> Promise<String?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
            }
            
            AF.request(heroRequest).responseString { response in
                switch response.result {
                case .success(let value):
                    fulfill(value)
                case .failure(let error):
                    //                    if response.error != nil {
                    reject(BaseAPIError(error: error))
                //                    }
                }
            }
        }
    }
}
