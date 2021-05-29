//
//  TokenManager.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/29.
//

import Foundation
import HeroCommon

final class TokenManager {
    public static let shared: TokenManager = TokenManager()
    public static let accessTokenKey: String = "AccessToken"
    public static let refreshTokenKey: String = "RefreshToken"
    public static let accessTokenExpiredKey: String = "AccessTokenExpiredAt"
    public static let refreshTokenExpiredKey: String = "RefreshTokenExpiredAt"
    
    public func getAccessToken() -> String? {
        return KeychainManager.shared.getString(TokenManager.accessTokenKey)
    }
    
    public func setAccessToken(token: String) -> Bool {
        return KeychainManager.shared.set(token, forKey: TokenManager.accessTokenKey)
    }
    
    public func getRefreshToken() -> String? {
        return KeychainManager.shared.getString(TokenManager.refreshTokenKey)
    }
    
    public func setRefreshToken(token: String) -> Bool {
        return KeychainManager.shared.set(token, forKey: TokenManager.refreshTokenKey)
    }
    
    public func setAccessTokenExpiredDate(expiredAt: Date) -> Bool {
        return KeychainManager.shared.set(expiredAt.convertToString(), forKey: TokenManager.accessTokenExpiredKey)
    }
    
    public func setRefreshTokenExpiredDate(expiredAt: Date) -> Bool {
        return KeychainManager.shared.set(expiredAt.convertToString(), forKey: TokenManager.refreshTokenExpiredKey)
    }
    
    public func getAccessTokenExpiredDate() -> Date? {
        return KeychainManager.shared.getString(TokenManager.accessTokenExpiredKey)?.convertToDate()
    }
    
    public func getRefreshTokenExpiredDate() -> Date? {
        return KeychainManager.shared.getString(TokenManager.refreshTokenExpiredKey)?.convertToDate()
    }
    
    public func deleteAllTokenData() -> Bool {
        let atResult = KeychainManager.shared.delete(TokenManager.accessTokenKey)
        let ateResult = KeychainManager.shared.delete(TokenManager.accessTokenExpiredKey)
        let rtResult = KeychainManager.shared.delete(TokenManager.refreshTokenKey)
        let rteResult = KeychainManager.shared.delete(TokenManager.refreshTokenExpiredKey)
        
        return atResult && ateResult && rtResult && rteResult
    }
    
    public func checkAccessTokenExpired() -> Bool {
        if let expiredAt = getAccessTokenExpiredDate() {
            return expiredAt < Date()
        } else {
            return false
        }
    }
    
    public func checkRefreshTokenExpired() -> Bool {
        if let expiredAt = getRefreshTokenExpiredDate() {
            return expiredAt < Date()
        } else {
            return false
        }
    }
}
