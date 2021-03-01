//
//  HeroTabBarController.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private func setupTabBarItems() {
        
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        HeroLog.debug("tabBarController didSelect update Navigation Title")
        
        switch tabBarController.selectedIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
}

extension MainTabBarViewController: HeroNavigationBarUpdatable { }

extension MainTabBarViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshShadowLine(offset: scrollView.contentOffset.y)
    }
}
