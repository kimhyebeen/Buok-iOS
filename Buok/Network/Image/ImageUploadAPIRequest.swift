//
//  ImageUploadAPIRequest.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/04.
//

import Foundation
import HeroCommon
import HeroNetwork
import HeroUI

struct ImageUploadServerModel: Codable {
    var status: Int
    var message: String
    var data: [String]?
}

public struct ImageUploadAPIRequest {
    enum ImageUploadRequestType: APIRequestType {
        case upload(images: [UIImage])
        
        var requestURL: URL {
            switch self {
            case .upload:
                return URL(string: HeroConstants.base + HeroConstants.images)!
            }
        }
        
        var requestParameter: [String: Any]? {
            nil
        }
        
        var httpMethod: HeroRequest.Method {
            .post
        }
        
        var encoding: HeroRequest.RequestEncoding {
            .json
        }
        
        var requestBody: [String: Any]? {
            nil
        }
        
        var imagesToUpload: [UIImage]? {
            switch self {
            case let .upload(images):
                return images
            }
        }
    }
    
    static func imageUploadRequest(images: [UIImage], responseHandler: @escaping (Result<[String], HeroAPIError>) -> Void) {
        BaseAPIRequest.multipartJSONResponse(requestType: ImageUploadRequestType.upload(images: images)).then { responseData in
            do {
                if let dictData = responseData as? NSDictionary {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                    DebugLog("responseData : \(dictData)")
                    DebugLog("Json Data : \n\(String(data: jsonData, encoding: .utf8) ?? "nil")")
                    
                    let getData = try JSONDecoder().decode(ImageUploadServerModel.self, from: jsonData)
                    if getData.status < 300, let signInData = getData.data {
                        responseHandler(.success(signInData))
                    } else {
                        responseHandler(.failure(HeroAPIError(errorCode: ErrorCode(rawValue: getData.status)!, statusCode: getData.status, errorMessage: getData.message)))
                    }
                }
            } catch {
                ErrorLog("ImageAPIRequest ERROR")
            }
        }
    }
}
