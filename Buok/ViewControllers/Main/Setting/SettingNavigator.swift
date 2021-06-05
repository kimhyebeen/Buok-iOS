//
//  SettingNavigator.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
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
        case .logout:
            DebugLog("Logout Clicked")
        case .withDrawal:
            DebugLog("WithDrawal Clicked")
        case .policy:
            DebugLog("Policy Clicked")
        }
        return destinationVC
    }
}
