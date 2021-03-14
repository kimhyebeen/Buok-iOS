//
//  KeywordRequest.swift
//  BucketList
//
//  Created by 김혜빈 on 2021/03/11.
//

import Alamofire
import Foundation
import Promise

public class KeywordRequest {
    
    func getKeywords(body: KeywordRequestBody) -> Promise<[KeywordItem]> {
        var request = URLRequest(url: URL(string: "http://svc.saltlux.ai:31781")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // Codable Model을 Data로 변환
        let requestBody = try? JSONEncoder().encode(body)
        if let requestBody = requestBody {
            request.httpBody = requestBody
        }
        
        return Promise { fulfill, reject in
            Alamofire.request(request).responseString { response in
                switch response.result {
                case .success:
                    if let data = response.data, let item = try? JSONDecoder().decode(KeywordResponse.self, from: data) {
                        fulfill(item.returnObject.keylists)
                    }
                case .failure:
                    reject(BaseAPIError(error: response.error))
                }
            }
        }
    }
}
