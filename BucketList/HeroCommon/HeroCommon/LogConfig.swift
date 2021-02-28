//
//  LogConfig.swift
//  HeroCommon
//
//  Created by Taein Kim on 2021/02/21.
//

import Foundation

final public class HeroLog {
    public class func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if SANDBOX || INHOUSE
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("🗣 [\(getCurrentTime())] \(#function) - \(output)", terminator: terminator)
        #else
            print("🗣 [\(getCurrentTime())] \(#function) - RELEASE MODE")
        #endif
    }
    
    public class func warning(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if SANDBOX || INHOUSE
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("⚡️ [\(getCurrentTime())] \(#function) - \(output)", terminator: terminator)
        #else
            print("⚡️ [\(getCurrentTime())] \(#function) - RELEASE MODE")
        #endif
    }
    
    public class func error(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if SANDBOX || INHOUSE
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("🚨 [\(getCurrentTime())] \(#function) - \(output)", terminator: terminator)
        #else
            print("🚨 [\(getCurrentTime())] \(#function) - RELEASE MODE")
        #endif
    }
    
    fileprivate class func getCurrentTime() -> String {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: now as Date)
    }
}
