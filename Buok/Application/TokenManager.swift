//
//  TokenManager.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon

final class TokenManager {
    public static let shared: TokenManager = TokenManager()
    
    public static let passwordResetTokenKey: String = "PasswordResetToken"
    public static let accessTokenKey: String = "AccessToken"
    public static let refreshTokenKey: String = "RefreshToken"
    public static let accessTokenExpiredKey: String = "AccessTokenExpiredAt"
    public static let refreshTokenExpiredKey: String = "RefreshTokenExpiredAt"
	public static let deviceFCMTokenKey: String = "DeviceFCMTokenKey"
    
    public func getPasswordResetToken() -> String? {
        return KeychainManager.shared.getString(TokenManager.passwordResetTokenKey)
    }
    
    public func setPasswordResetToken(token: String) -> Bool {
        return KeychainManager.shared.set(token, forKey: TokenManager.passwordResetTokenKey)
    }
    
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
        let prtResult = KeychainManager.shared.delete(TokenManager.passwordResetTokenKey)
        
        return atResult && ateResult && rtResult && rteResult && prtResult
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
	
	public func getFCMToken() -> String? {
		return KeychainManager.shared.getString(TokenManager.deviceFCMTokenKey)
	}
	
	public func setFCMToken(token: String) -> Bool {
		return KeychainManager.shared.set(token, forKey: TokenManager.deviceFCMTokenKey)
	}
}
