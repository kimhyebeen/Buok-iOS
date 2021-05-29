//
//  KeychainManager.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String
}

class KeychainManager {
    public static let shared = KeychainManager()
    private let service = "서비스 이름"
    private let account = "사용자 계정"
    
    private init() {}
    
    func createUser(_ user: User) -> Bool {
        guard let data = try? JSONEncoder().encode(user) else { return false }
        
        let query: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                       kSecAttrService : service,
                                       kSecAttrAccount : account,
                                       kSecAttrGeneric : data]
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    func readUser() -> User? {
        let query: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                       kSecAttrService : service,
                                       kSecAttrAccount : account,
                                       kSecMatchLimit : kSecMatchLimitOne,
                                       kSecReturnAttributes : true,
                                       kSecReturnData : true]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
        
        guard let existingItem = item as? [CFString : Any],
              let data = existingItem[kSecAttrGeneric] as? Data,
              let user = try? JSONDecoder().decode(User.self, from: data) else { return nil }
        return user
    }

    func updateUser(_ user: User) -> Bool {
        guard let data = try? JSONEncoder().encode(user) else { return false }
        
        let guery: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                       kSecAttrService : service,
                                       kSecAttrAccount : account]
        let attributes: [CFString : Any] = [kSecAttrAccount : account,
                                            kSecAttrGeneric : data]
        return SecItemUpdate(guery as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    func deleteUser() -> Bool {
        let query: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                       kSecAttrService : service,
                                       kSecAttrAccount : account]
        
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}
