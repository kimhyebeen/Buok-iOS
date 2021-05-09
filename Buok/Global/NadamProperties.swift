//
//  NadamProperties.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/17.
//

import Foundation
import HeroCommon
import HeroUI

public enum BucketStatus {
    case none
    case pre
    case present
    case success
    case failure
    
    public func getTitle() -> String {
        switch self {
        case .none:
            return ""
        case .pre:
            return "Hero_Add_Bucket_Predestination".localized
        case .present:
            return "Hero_Add_Bucket_Present".localized
        case .success:
            return "Hero_Add_Bucket_Success".localized
        case .failure:
            return "Hero_Add_Bucket_Failure".localized
        }
    }
}

public enum NadamUserStatus: Int {
    case guest = 0
    case normal
    case power
    case admin
}

public class NadamProperties: NSObject {
    private struct KeyConstants {
        static let isPasswordLock = "isPasswordLock"
        static let orientation = "orientation"
    }
    
    static var shared = NadamProperties()
    
    deinit {
        DebugLog("NadamProperties deinit")
    }
    
    func resetCommonProperties() {
        
    }
    
    lazy var model: String = {
        let model: String = UIDevice.current.model
        return model
    }()
    
    lazy var userAgent: String = {
        let userAgent = "KT \(appVersion)"
        return userAgent
    }()
    
    lazy var appVersion: String = {
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "N/A"
        return appVersion
    }()
}
