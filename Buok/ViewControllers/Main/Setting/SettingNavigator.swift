//
//  SettingNavigator.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/11.
//

import Foundation
import HeroCommon
import HeroUI

final class SettingNavigator {
    static func getDestViewController(type: SettingType) -> UIViewController? {
        var destinationVC: UIViewController?
        switch type {
        case .mail:
            DebugLog("Mail Clicked")
            let sampleVC = UIViewController()
            sampleVC.view.backgroundColor = .heroGraySample100s
            destinationVC = sampleVC
        case .connectedAccount:
            DebugLog("Connected Account Clicked")
        case .appVersion:
            DebugLog("App Version Clicked")
        case .lock:
            DebugLog("Lock Clicked")
        case .language:
            DebugLog("Language Clicked")
        case .notification:
            DebugLog("Notification Clicked")
        case .dataManagement:
            DebugLog("Data Management Clicked")
        case .backup:
            DebugLog("Backup Clicked")
        case .contact:
            DebugLog("Contact Clicked")
        }
        return destinationVC
    }
}
