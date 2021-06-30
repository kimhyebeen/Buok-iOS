//
//  ServiceInfoData.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon

class ServiceInfoData {
    let termsOfService: String = ""

    static func loadContentIntoString(name: String) -> String {
        do {
            guard let fileUrl = Bundle.main.url(forResource: name, withExtension: "txt") else { fatalError() }
            let text = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
            return text
        } catch {
            ErrorLog(error.localizedDescription)
        }
        return ""
    }
    
    static func getCurrentVersionInfo() -> String? {
        guard let dictionary = Bundle.main.infoDictionary,
           let version = dictionary["CFBundleShortVersionString"] as? String,
           let build = dictionary["CFBundleVersion"] as? String else {
            return nil
        }
        
        let versionAndBuild: String = "vserion: \(version), build: \(build)"
        DebugLog("Version : \(versionAndBuild)")
        return version
    }
}
