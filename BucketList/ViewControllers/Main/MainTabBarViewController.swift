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
    // MARK: Center Action Button
    private struct Constants {
        static let actionButtonSize = CGSize(width: 64, height: 64)
    }
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .heroBlue100s
        button.layer.cornerRadius = Constants.actionButtonSize.height / 2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.setImage(UIImage(named: "tab_home.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .heroWhite100s
        
        button.addTarget(self, action: #selector(actionButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
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
        
        view.addSubview(actionButton)
        
        setupTabBarItems()
        setupActionButtonConstraints()
    }
    
    private func setupTabBarItems() {
        var viewControllerList = [UIViewController]()
        let homeVC = ViewController()
        let homeItem = UITabBarItem(title: "", image: UIImage(named: "tab_home_un.png"), selectedImage: UIImage(named: "tab_home.png"))
        homeVC.tabBarItem = homeItem
        viewControllerList.append(homeVC)
        
        let secondVC = SecondViewController()
        let secondItem = UITabBarItem(title: "", image: UIImage(named: "tab_home_un.png"), selectedImage: UIImage(named: "tab_home.png"))
        secondVC.tabBarItem = secondItem
        viewControllerList.append(secondVC)
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .heroBlue100s
        
        
        self.viewControllers = viewControllerList
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        DebugLog("tabBarController didSelect update Navigation Title")
        
        switch tabBarController.selectedIndex {
        case 0:
            titleLabel.text = "타이틀"
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
    
    @objc private func actionButtonTapped(sender: UIButton) {
        DebugLog("Action Button Tapped")
    }
    
    private func setupActionButtonConstraints() {
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.actionButtonSize.width)
            make.height.equalTo(Constants.actionButtonSize.height)
            make.bottom.equalTo(tabBar.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension MainTabBarViewController: HeroNavigationBarUpdatable { }

extension MainTabBarViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshShadowLine(offset: scrollView.contentOffset.y)
    }
}
