//
//  HeroConvertible.swift
//  BucketList
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Alamofire
import Foundation

public protocol HeroRequestConvertible: URLRequestConvertible {
	var httpMethod: Alamofire.HTTPMethod { get }
	var path: String { get }
	var fullAPIPath: String { get }
}

public extension HeroRequestConvertible {
	var fullAPIPath: String {
		return "\(HeroConstants.base)"
	}
}

public protocol HeroResponseConvertible {
	var responseHeaders: [AnyHashable: Any] { get }
	var responseValue: Any? { get }
	var error: HeroAPIError? { get }
	var isSuccess: Bool { get }
}
