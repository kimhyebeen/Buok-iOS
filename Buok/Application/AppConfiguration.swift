//
//  AppConfiguration.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/29.
//

import Foundation
import HeroCommon

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    var isAutoLogin: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "isAutoLogin".asDefaultKey) as? Bool) ?? true
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "isAutoLogin".asDefaultKey)
        }
    }
    
    var accessToken: String {
        get {
            return (UserDefaults.standard.value(forKey: "ApiKey".asDefaultKey) as? String) ?? ""
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "ApiKey".asDefaultKey)
        }
    }
    
    var refreshToken: String {
        get {
            return (UserDefaults.standard.value(forKey: "RefreshToken".asDefaultKey) as? String) ?? ""
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "RefreshToken".asDefaultKey)
        }
    }
    
    var expiredDate: String {
        get {
            return (UserDefaults.standard.value(forKey: "ExpiredDate".asDefaultKey) as? String) ?? ""
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "ExpiredDate".asDefaultKey)
        }
    }
}
