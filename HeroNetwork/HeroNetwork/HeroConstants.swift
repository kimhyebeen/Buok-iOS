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
    public static var authURL: URL {
        var urlComponents = URLComponents()
        urlComponents.path = "/auth"
        return urlComponents.url!
    }
    
    public static var userURL: URL {
        var urlComponents = URLComponents()
        urlComponents.path = "/user"
        return urlComponents.url!
    }
    
    #if SANDBOX
    public static let homeURL = URL(string: "https://api.mocki.io")!
    #elseif INHOUSE
    public static let homeURL = URL(string: "https://api.mocki.io")!
    #elseif REAL
    public static let homeURL = URL(string: "https://api.mocki.io")!
    #else
    public static let homeURL = URL(string: "https://api.mocki.io")!
    #endif
}
