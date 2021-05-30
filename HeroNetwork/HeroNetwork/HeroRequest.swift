//
//  HeroRequest.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Alamofire
import Foundation

public class HeroRequest: HeroRequestConvertible, CustomStringConvertible {
	public enum Method {
		case get
		case post
		case delete
		case put
		case patch
		
		var httpMethod: HTTPMethod {
			switch self {
			case .get:
				return .get
			case .post:
				return .post
			case .delete:
				return .delete
			case .put:
				return .put
			case .patch:
				return .patch
			}
		}
	}
	
	public enum RequestEncoding {
		case url
		case urlQuery
		case json
		
		var parameterEncoding: ParameterEncoding {
			switch self {
			case .url:
				return URLEncoding.default
			case .urlQuery:
				return URLEncoding.queryString
			case .json:
				return JSONEncoding.default
			}
		}
	}
	
	public var requestedHeaders: [String: String]?
	public var requestParameters: [String: Any]?
	public var path: String
	public var httpMethod: HTTPMethod
	public var encoding: ParameterEncoding
	public var requestBody: [String: Any]?
	
	open var requestHeaders: [HeroHeader] = []
	
	required public init(path: String, httpMethod: Method = .get, encoding: RequestEncoding, parameter: [String: Any]? = nil, requestBody: [String: Any]? = nil) {
		self.path = path
		self.httpMethod = httpMethod.httpMethod
		self.requestParameters = parameter
		self.encoding = encoding.parameterEncoding
		self.requestBody = requestBody
	}
	
	public func asURLRequest() throws -> URLRequest {
		let url = try "\(fullAPIPath)\(path)".asURL()
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = httpMethod.rawValue
		urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
		if let requestBody = requestBody {
			let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
			urlRequest.httpBody = httpBody
		}
		
//		let newHeaders = [HeroHeader.token, HeroHeader.accept]
//
//        newHeaders.forEach { newHeader in
//            if !requestHeaders.contains(where: { $0.key == newHeader.key }) {
//                requestHeaders.append(newHeader)
//            }
//        }

//        mandatoryHeaders.forEach { newHeader in
//            if !requestHeaders.contains(where: { $0.key == newHeader.key }) {
//                requestHeaders.append(newHeader)
//            }
//        }

        requestHeaders.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
		
		requestedHeaders = urlRequest.allHTTPHeaderFields
		urlRequest.timeoutInterval = 60
		return try encoding.encode(urlRequest, with: requestParameters)
	}
	
    var requestHeaderDictionary: [String: Any] {
        return requestHeaders.reduce([String: Any]()) {
            var dict = $0
            dict[$1.key] = $1.value
            return dict
        }
    }

    public var debugParameterDesc: String {
        if let paramString = requestParameters?.description, paramString.count > 2000 {
            return String(paramString.prefix(2000)) + "..."
        } else {
            return requestParameters?.description ?? ""
        }
    }

    public var description: String {
        var desc = " [Path] \(fullAPIPath)\n[Method] \(httpMethod)"
        if let headers = requestedHeaders {
            desc += "\n> Headers:\(headers)"
        } else {
            desc += "\n> Headers: nil"
        }

        desc += "\n> Parameters: \(debugParameterDesc)"
        return desc

    }
}
