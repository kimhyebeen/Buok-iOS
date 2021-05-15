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
    private let addButton: UIButton = {
        $0.backgroundColor = .heroWhite100s
        $0.setImage(UIImage(heroSharedNamed: "tab_add.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .heroGray600s
        $0.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        $0.addTarget(self, action: #selector(onClickAddButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var tabViewControllers: [UIViewController] = [UIViewController]()
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: self.tabBar.center.x - 22, y: self.tabBar.frame.origin.y, width: 44, height: 44)
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
    }

    private func setupTabBarItems() {
        let homeVC = HomeViewController()
        homeVC.viewModel = HomeViewModel()
        
        let mypageVC = MypageViewController()
        
        let homeNC = createNavController(for: homeVC,
                                         normalImage: UIImage(heroSharedNamed: "tab_home.png"),
                                         selectedImage: UIImage(heroSharedNamed: "tab_home.png"))
        
        let addNC = createNavController(for: UIViewController(),
                                        normalImage: nil,
                                        selectedImage: nil)
        
        let mypageNC = createNavController(for: mypageVC,
                                           normalImage: UIImage(heroSharedNamed: "tab_mypage.png"), selectedImage: UIImage(heroSharedNamed: "tab_mypage.png"))
        
        tabViewControllers.removeAll()
        tabViewControllers.append(homeNC)
        tabViewControllers.append(addNC)
        tabViewControllers.append(mypageNC)
        
        tabBar.barTintColor = .heroWhite100s
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
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         normalImage: UIImage?,
                                         selectedImage: UIImage?) -> UIViewController {
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
