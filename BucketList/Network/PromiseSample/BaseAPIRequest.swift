//
//  BaseAPIRequest.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Alamofire
import Foundation
import HeroCommon
import Promise
import SwiftyJSON

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

public class BaseAPIRequest {
    typealias RequestType = APIRequestType
    
    func requestJSONResponse(requestType: RequestType) -> Promise<Any?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
            }
            
            Alamofire.request(heroRequest).responseJSON { response in
                if response.result.isSuccess, let value = response.result.value {
                    fulfill(value)
                } else {
                    if response.error != nil {
                        reject(BaseAPIError(error: response.error))
                    }
                }
            }
        }
    }
    
    func requestStringResponse(requestType: RequestType) -> Promise<String?> {
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
