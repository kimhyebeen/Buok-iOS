//
//  String+Extension.swift
//  HeroCommon
//
//  Created by Taein Kim on 2021/05/29.
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
    
    func convertToSmallDate() -> Date {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        let date: Date = dateFormatter.date(from: self)!
        return date
    }
}
