//
//  NadamProperties.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/17.
//

import Foundation
import HeroCommon
import HeroUI

public enum BucketStatus: Int {
    case pre = 0
    case present = 1
    case success = 2
    case failure = 3
    
    public func getTitle() -> String {
        switch self {
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

public enum BucketCategory: Int {
    case travel = 2
    case hobby = 3
    case own = 4
    case financial = 5
    case health = 6
    case goal = 7
    case organization = 8
    case volunteer = 9
    case other = 10
    case noCategory = 1
    
    public func getTitle() -> String {
        switch self {
        case .travel:
            return "Hero_Add_Category_Travel".localized
        case .hobby:
            return "Hero_Add_Category_Hobby".localized
        case .own:
            return "Hero_Add_Category_Own".localized
        case .financial:
            return "Hero_Add_Category_Finance".localized
        case .health:
            return "Hero_Add_Category_Health".localized
        case .goal:
            return "Hero_Add_Category_Goal".localized
        case .organization:
            return "Hero_Add_Category_Group".localized
        case .volunteer:
            return "Hero_Add_Category_Volunteer".localized
        case .other:
            return "Hero_Add_Category_Others".localized
        case .noCategory:
            return ""
        }
    }
    
    public func getIcon() -> UIImage? {
        switch self {
        case .travel:
            return UIImage(heroSharedNamed: "ic_fill_travel")
        case .hobby:
            return UIImage(heroSharedNamed: "ic_fill_hobby")
        case .own:
            return UIImage(heroSharedNamed: "ic_fill_want")
        case .financial:
            return UIImage(heroSharedNamed: "ic_fill_finance")
        case .health:
            return UIImage(heroSharedNamed: "ic_fill_health")
        case .goal:
            return UIImage(heroSharedNamed: "ic_fill_goal")
        case .organization:
            return UIImage(heroSharedNamed: "ic_fill_community")
        case .volunteer:
            return UIImage(heroSharedNamed: "ic_fill_volunteer")
        case .other:
            return UIImage(heroSharedNamed: "ic_fill_etc")
        case .noCategory:
            return nil
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
