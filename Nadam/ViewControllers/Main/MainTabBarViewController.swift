//
//  HeroTabBarController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

public class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let actionButton: TabBarActionButton = TabBarActionButton()
    private let tabBarView: HeroTabBarView = HeroTabBarView()
    
    private var tabViewControllers: [UIViewController] = [UIViewController]()
    private var currentIndex: Int = 0
    private var previousIndex: Int = 0
    
    private let tabBarItemList: [HeroTabBarItem] = [
        HeroTabBarItem(title: nil,
                       image: UIImage(heroSharedNamed: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: false),
        HeroTabBarItem(title: nil,
                       image: UIImage(heroSharedNamed: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: false),
        HeroTabBarItem(title: nil,
                       image: UIImage(heroSharedNamed: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: false)
    ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLayout()
        setupViewProperties()
        setupTabBarItems()
        tabChanged(tapped: 0)
    }
    
    private func setupMainLayout() {
        view.addSubview(tabBarView)
        view.bringSubviewToFront(tabBarView)
        
        tabBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(MainTabBarConstants.outerSpacing)
            make.trailing.equalToSuperview().offset(-MainTabBarConstants.outerSpacing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-MainTabBarConstants.outerSpacing)
            make.height.equalTo(MainTabBarConstants.tabBarHeight)
        }
    }
    
    private func setupViewProperties() {
        self.delegate = self
        self.tabBar.isHidden = true
        
        tabBarView.delegate = self
        tabBarView.itemList = tabBarItemList
        tabBarView.borderRadius = 12
    }
    
    private func setupTabBarItems() {
        let homeVC = HomeViewController()
        let homeItem = UITabBarItem(title: "", image: UIImage(heroSharedNamed: "tab_home_un.png"), selectedImage: UIImage(heroSharedNamed: "tab_home.png"))
        
        let mypageVC = MyPageViewController()
        let mypageItem = UITabBarItem(title: "", image: UIImage(heroSharedNamed: "tab_home_un.png"), selectedImage: UIImage(heroSharedNamed: "tab_home.png"))
        
        let homeNavVC = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        homeNavVC.viewControllers = [homeVC]
        homeNavVC.tabBarItem = homeItem
        
        let mypageNavVC = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        mypageNavVC.viewControllers = [mypageVC]
        mypageNavVC.tabBarItem = mypageItem
        
        tabViewControllers.removeAll()
        tabViewControllers.append(homeNavVC)
        tabViewControllers.append(UIViewController())
        tabViewControllers.append(mypageNavVC)
    }
    
    @objc
    private func clickFloatingButton(_ sender: UIButton) {
        DebugLog("Click Floating Button")
    }
    
    @objc
    private func tabChanged(tapped index: Int) {
        if index != 1 {
            previousIndex = currentIndex
            currentIndex = index
            tabBarView.setTabBarItemSelected(index: currentIndex, isSelected: true)
            let previousVC = tabViewControllers[previousIndex]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            
            let vc = tabViewControllers[currentIndex]
            vc.view.frame = UIApplication.shared.windows[0].frame
            vc.didMove(toParent: self)
            self.addChild(vc)
            self.view.addSubview(vc.view)
            self.view.bringSubviewToFront(tabBarView)
        } else {
            let vc = UIViewController()
            vc.view.backgroundColor = .heroWhite100s
//            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension MainTabBarViewController: HeroNavigationBarUpdatable { }

extension MainTabBarViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshShadowLine(offset: scrollView.contentOffset.y)
    }
}

extension MainTabBarViewController: HeroTabBarViewDelegate {
    public func tabBarItem(at index: Int) {
        tabChanged(tapped: index)
    }
}
