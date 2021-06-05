//
//  AppConfiguration.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
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
