//
//  PromiseSample.swift
//  BucketList
//
//  Created by denny on 2021/03/02.
//

import Alamofire
import Foundation
import HeroCommon
import Promise

public class PromiseSampleAPIRequest {
    public enum RequestMethod {
        case get
        case post
        case delete
        case put
        
        func getMethod() -> HTTPMethod {
            switch self {
            case .get:
                return .get
            case .post:
                return .post
            case .delete:
                return .delete
            case .put:
                return .put
            }
        }
    }
    
    private let sessionManager: SessionManager = makeSessionManager()
    private static let sessionDelegate = HeroSessionDelegate()
    
    private var method: RequestMethod
    
    public init(method: RequestMethod) {
        self.method = method
    }
    
    class func makeSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpMaximumConnectionsPerHost = 1
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let sessionManager = SessionManager(configuration: configuration, delegate: sessionDelegate, serverTrustPolicyManager: nil)
        return sessionManager
    }
    
    func getUserInfo() -> Promise<[String: Any]> {
        return Promise { fulfill, reject in
//            Alamofire.request("https://jsonplaceholder.typicode.com/users/1")
//                .validate()
            self.sessionManager.request("https://jsonplaceholder.typicode.com/users/1")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let json = json as? [String: Any] else {
                            return reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        fulfill(json)
                    case .failure(let error):
                        reject(error)
                    }
                }
        }
    }
}

class HeroSessionDelegate: SessionDelegate {
    override open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        super.urlSession(session, dataTask: dataTask, didReceive: data)
        if let requestPath = dataTask.originalRequest?.url?.path,
            requestPath == "/listen" {
            if let listenTaskDidReceiveData = listenTaskDidReceiveData {
                listenTaskDidReceiveData(session, dataTask, data)
            }
        }
    }
    
     open var listenTaskDidReceiveData: ((URLSession, URLSessionDataTask, Data) -> Void)?
    
}
