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
    private let titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 24))
    private let titleLabel: UILabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        navigationItem.titleView = titleView
        titleView.addSubview(titleLabel)
        titleView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.font = .font17PBold
        titleLabel.textColor = .black
        titleLabel.text = "타이틀"
        
        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
        var viewControllerList = [UIViewController]()
        let homeVC = ViewController()
        let homeItem = UITabBarItem(title: "", image: UIImage(named: "tab_home_un.png"), selectedImage: UIImage(named: "tab_home.png"))
        homeVC.tabBarItem = homeItem
        viewControllerList.append(homeVC)
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .heroBlue100s
        
        self.viewControllers = viewControllerList
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        HeroLog.debug("tabBarController didSelect update Navigation Title")
        
        switch tabBarController.selectedIndex {
        case 0:
            titleLabel.text = "타이틀"
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
