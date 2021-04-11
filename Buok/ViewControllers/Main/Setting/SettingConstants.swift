//
//  SettingConstants.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/11.
//

import Foundation

enum SettingCellType: Int {
    case normal = 0
    case info
    case button
}

enum SettingType: Int {
    case mail = 0
    case connectedAccount
    case appVersion
    case lock
    case language
    case notification
    case dataManagement
    case backup
    case contact
    
    func getTitle() -> String {
        switch self {
        case .mail:
            return "메일 주소"
        case .connectedAccount:
            return "연결된 계정"
        case .appVersion:
            return "앱 버전"
        case .lock:
            return "잠금"
        case .language:
            return "언어"
        case .notification:
            return "알림"
        case .dataManagement:
            return "저장 데이터 관리"
        case .backup:
            return "백업"
        case .contact:
            return "연락처"
        }
    }
}
