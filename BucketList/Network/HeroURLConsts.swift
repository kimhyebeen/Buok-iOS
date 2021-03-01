//
//  HeroURLConsts.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation

public class HeroURLConsts {
    static let version = "v1"
    static let baseURLSandbox = "http://www.naver.com"
    static let baseURLReal = "http://www.naver.com"
    
    static var baseUrlString: String {
        #if SANDBOX
        return HeroURLConsts.baseURLSandbox
        #else
        return HeroURLConsts.baseURLReal
        #endif
    }
}
