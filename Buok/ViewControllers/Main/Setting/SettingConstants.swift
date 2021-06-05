//
//  SettingConstants.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

enum SettingCellType: Int {
    case normal = 0
    case info
    case button
    case buttonWithNoImage
}

enum SettingType: Int {
    case mail = 0
    case connectedAccount
    case appVersion
    case logout
    case withDrawal
    case policy
    
    func getTitle() -> String {
        switch self {
        case .mail:
            return "메일 주소"
        case .connectedAccount:
            return "연결된 계정"
        case .appVersion:
            return "앱 버전"
        case .logout:
            return "로그아웃"
        case .withDrawal:
            return "탈퇴"
        case .policy:
            return "개인정보보호정책"
        }
    }
}
