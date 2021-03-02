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
    
    private var method: RequestMethod
    
    public init(method: RequestMethod) {
        self.method = method
    }
    
    func getUserInfo() -> Promise<[String: Any]> {
        return Promise { fulfill, reject in
            Alamofire.request("https://jsonplaceholder.typicode.com/users/1")
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
