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
        return "reqres.in/api/users/"
        #else
        return "reqres.in/api/users/"
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
    static let homeURL = URL(string: "https://api.mocki.io")!
    #elseif INHOUSE
    static let homeURL = URL(string: "https://api.mocki.io")!
    #elseif REAL
    static let homeURL = URL(string: "https://api.mocki.io")!
    #else
    static let homeURL = URL(string: "https://api.mocki.io")!
    #endif
}
