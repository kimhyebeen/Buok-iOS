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
    
    var isInitialLaunch: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "isInitialLaunch".asDefaultKey) as? Bool) ?? true
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "isInitialLaunch".asDefaultKey)
        }
    }
}
