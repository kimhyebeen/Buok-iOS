//
//  HeroTabBarController.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

protocol MainTabBarDelegate: AnyObject {
    func hideTabBar()
    func showTabBar()
}

public class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let addButton: UIButton = {
//        $0.backgroundColor = .heroGrayE7E1DC
        $0.backgroundColor = .clear
        $0.setImage(UIImage(heroSharedNamed: "tab_add.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .heroGray600s
        $0.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        $0.addTarget(self, action: #selector(onClickAddButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let tabBarBorderView: UIView = {
        $0.backgroundColor = .heroGrayC7BFB8
        return $0
    }(UIView())
    
    private var tabViewControllers: [UIViewController] = [UIViewController]()
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addButton.frame = CGRect(x: self.tabBar.center.x - 22, y: self.tabBar.frame.origin.y, width: 50, height: 50)
        
        tabBarBorderView.frame = CGRect(x: self.tabBar.frame.origin.x, y: self.tabBar.frame.origin.y, width: self.tabBar.frame.width, height: 1.5)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        navigationController?.isNavigationBarHidden = true
        setupTabBarItems()
        self.view.insertSubview(addButton, aboveSubview: self.tabBar)
        self.view.insertSubview(tabBarBorderView, aboveSubview: self.tabBar)
    }

    private func setupTabBarItems() {
        let homeVC = HomeViewController()
        homeVC.viewModel = HomeViewModel()
        homeVC.tabBarDelegate = self
        
        let profileVC = ProfileViewController()
        let profileViewModel = ProfileViewModel()
        profileVC.viewModel = profileViewModel
        profileVC.isMyPage = true
        
        let homeNC = createNavController(for: homeVC,
                                         normalImage: UIImage(heroSharedNamed: "tab_home_un.png"),
                                         selectedImage: UIImage(heroSharedNamed: "tab_home.png"))
        
        let addNC = createNavController(for: HeroBaseViewController(),
                                        normalImage: nil,
                                        selectedImage: nil)
        
        let profileNC = createNavController(for: profileVC,
                                            normalImage: UIImage(heroSharedNamed: "tab_mypage_un.png"), selectedImage: UIImage(heroSharedNamed: "tab_mypage.png"))
        
        tabViewControllers.removeAll()
        tabViewControllers.append(homeNC)
        tabViewControllers.append(addNC)
        tabViewControllers.append(profileNC)
        
        tabBar.barTintColor = .heroGrayE7E1DC
        tabBar.tintColor = .heroGray600s

        viewControllers = tabViewControllers
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    public func tabBarController(_: UITabBarController, didSelect _: UIViewController) {
        DebugLog("tabBarController didSelect update Navigation Title")
    }
    
    @objc
    private func onClickAddButton(_ sender: Any) {
        let vc = CreateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func createNavController(for rootViewController: HeroBaseViewController,
                                         normalImage: UIImage?,
                                         selectedImage: UIImage?) -> UIViewController {
        rootViewController.tabBarDelegate = self
        let navController = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navController.tabBarItem = UITabBarItem(title: "", image: normalImage, selectedImage: selectedImage)
        navController.viewControllers = [rootViewController]
        return navController
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
//        tabChanged(tapped: index)
    }
}

extension MainTabBarViewController: MainTabBarDelegate {
    func hideTabBar() {
        addButton.isHidden = true
        tabBarBorderView.isHidden = true
        self.tabBar.isHidden = true
    }
    
    func showTabBar() {
        addButton.isHidden = false
        tabBarBorderView.isHidden = false
        self.tabBar.isHidden = false
    }
}
