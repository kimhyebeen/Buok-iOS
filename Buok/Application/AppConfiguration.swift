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
    
//    func getAccessToken(resultHandler: @escaping (String) -> ()) {
//        KeychainManager.shared.getAccessToken(handler: { (result, token) in
//            resultHandler(token ?? "")
//        })
//    }
//    
//    func setAccessToken(accessToken: String) -> Bool {
//        return KeychainManager.shared.setAccessToken(accessToken: accessToken)
//    }
//    
//    func getRefreshToken(resultHandler: @escaping (String) -> ()) {
//        KeychainManager.shared.getRefreshToken(handler: { (result, token) in
//            resultHandler(token ?? "")
//        })
//    }
//    
//    func setRefreshToken(refreshToken: String) -> Bool {
//        return KeychainManager.shared.setRefreshToken(refreshToken: refreshToken)
//    }
    
    var expiredDate: String {
        get {
            return (UserDefaults.standard.value(forKey: "ExpiredDate".asDefaultKey) as? String) ?? ""
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "ExpiredDate".asDefaultKey)
        }
    }
}
