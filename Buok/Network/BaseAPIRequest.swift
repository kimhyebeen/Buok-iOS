//
//  BaseAPIRequest.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Alamofire
import Foundation
import HeroCommon
import HeroNetwork
import HeroUI
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
    var imagesToUpload: [UIImage]? { get }
}

extension APIRequestType {
    var requestHeaders: [HeroHeader]? {
        [.token(TokenManager.shared.getAccessToken() ?? ""), .accept, .contentType]
    }
}

public class BaseAPIRequest {
    //	typealias RequestType = APIRequestType
    
    static func multipartJSONResponse(requestType: APIRequestType) -> Promise<Any?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            var headers: HTTPHeaders = []
            requestType.requestHeaders?.forEach {
                headers[$0.key] = $0.value
            }
            
            DebugLog("HTTP Headers : \(headers.description)")
            DebugLog("Request URL : \(requestType.requestURL.absoluteString)")
            
            if let images = requestType.imagesToUpload {
                AF.upload(multipartFormData: { multipartFormData in
                    images.forEach { image in
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            multipartFormData.append(imageData, withName: "image", fileName: "a.jpg", mimeType: "image/jpg")
                        }
                    }
                }, to: url, method: .post, headers: headers)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        fulfill(value)
                    case .failure(let error):
                        reject(BaseAPIError(error: error))
                    }
                })
            } else {
                reject(BaseAPIError.unknown)
            }
        }
    }
    
    static func requestJSONResponse(requestType: APIRequestType) -> Promise<Any?> {
        Promise { fulfill, reject in
            let url = requestType.requestURL
            let heroRequest = HeroRequest(path: url.path, httpMethod: requestType.httpMethod, encoding: requestType.encoding, parameter: requestType.requestParameter)
            
            if let requestHeaders = requestType.requestHeaders {
                heroRequest.requestHeaders = requestHeaders
                DebugLog("HTTP Headers : \(requestHeaders.description)")
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
                DebugLog("HTTP Headers : \(requestHeaders.description)")
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
