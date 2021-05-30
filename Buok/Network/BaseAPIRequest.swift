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
//        [.token(TokenManager.shared.getAccessToken() ?? ""), .accept, .contentType]
		[.token("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzNyIsImV4cCI6MTYyNDE2OTk3Mn0.q93SST4PVGbiec-wKfiX8yJgT1NH_0nV6mE73IQXVmI"), .accept]
	}
}

public class BaseAPIRequest {
	typealias RequestType = APIRequestType
	
    static func requestJSONResponse(requestType: RequestType) -> Promise<Any?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
            }
			
			if let requestBodyBucket = requestType.requestBody {
				heroRequest.requestBody = requestBodyBucket
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
