//
//  String+Extension.swift
//  HeroCommon
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

public extension String {
    var asDefaultKey: String {
        #if REAL || INHOUSE
        return self
        #elseif SANDBOX
        return "sandbox." + self
        #endif
    }
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        let date: Date = dateFormatter.date(from: self)!
        return date
    }
	
	func convertToOnlyDate() -> Date {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "yyyy-MM-dd"
		dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

		let date: Date = dateFormatter.date(from: self)!
		return date
	}
    
//    func convertToSmallDate() -> Date {
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//
//        let date: Date = dateFormatter.date(from: self)!
//        return date
//    }
}
