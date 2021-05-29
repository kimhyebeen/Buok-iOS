//
//  String+Extension.swift
//  HeroCommon
//
//  Created by denny on 2021/05/29.
//

import Foundation

extension String {
    var asDefaultKey: String {
        #if REAL || INHOUSE
        return self
        #elseif SANDBOX
        return "sandbox." + self
        #endif
    }
}
