//
//  HeroConstants.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Foundation

public struct HeroConstants {
    public static var hostName: String {
        #if SANDBOX
        return "sandbox.test.com"
        #else
        return "production.test.com"
        #endif
    }
}

public struct APIConstant {
    static var authURL: URL {
        var urlComponents = URLComponents()
        urlComponents.path = "/auth"
        return urlComponents.url!
    }
    
    static var userURL: URL {
        var urlComponents = URLComponents()
        urlComponents.path = "/user"
        return urlComponents.url!
    }
    
    #if SANDBOX
    static let homeURL = URL(string: "https://home-sandbox.test.com")!
    #elseif INHOUSE
    static let homeURL = URL(string: "https://home-inhouse.test.com")!
    #elseif REAL
    static let homeURL = URL(string: "https://home.test.com")!
    #else
    static let homeURL = URL(string: "https://home.test.com")!
    #endif
}
