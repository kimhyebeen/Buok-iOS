//
//  BaseAPIRequest.swift
//  BucketList
//
//  Created by denny on 2021/03/03.
//

import Alamofire
import Foundation
import HeroCommon
import Promise

protocol APIRequestType {
    var requestURL: URL { get }
    var requestParameter: [String: Any]? { get }
    var httpMethod: HeroRequest.Method { get }
    var encoding: HeroRequest.RequestEncoding { get }
    var requestHeaders: [HeroHeader]? { get }
}

extension APIRequestType {
    var requestHeaders: [HeroHeader]? {
        nil
    }
}

protocol BaseAPIRequestable {
    associatedtype RequestType: APIRequestType
    
    static func request<T: Codable>(requestType: RequestType, modifyValue: (([String: Any]) -> [String: Any])?) -> Promise<T>
    static func request(requestType: RequestType) -> Promise<Void>
}

extension BaseAPIRequestable {
    static func requestJSONResponse(requestType: RequestType) -> Promise<[String: Any]?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
            }
            
            Alamofire.request(heroRequest).responseJSON { response in
                if response.result.isSuccess {
                    fulfill(response.result.value as? [String: Any])
                } else {
                    if response.error != nil {
                        reject(BaseAPIError(error: response.error))
                    }
                }
            }
        }
    }
    
    static func requestStringResponse(requestType: RequestType) -> Promise<String?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
            }
            
            Alamofire.request(heroRequest).responseString { response in
                if response.result.isSuccess {
                    fulfill(response.result.value)
                } else {
                    if response.error != nil {
                        reject(BaseAPIError(error: response.error))
                    }
                }
            }
        }
    }
}
