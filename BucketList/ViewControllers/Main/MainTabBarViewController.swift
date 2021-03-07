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
    private let actionButton: TabBarActionButton = TabBarActionButton()
    private let tabBarView: HeroTabBarView = HeroTabBarView()
    private let tabBarBackView: UIView = UIView()
    
    private var tabViewControllers: [UIViewController] = [UIViewController]()
    private var currentIndex: Int = 0
    private var previousIndex: Int = 0
    
    private let tabBarItemList: [HeroTabBarItem] = [
        HeroTabBarItem(title: "Item1",
                       image: UIImage(named: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: false),
        HeroTabBarItem(title: "Item2",
                       image: UIImage(named: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: false),
        HeroTabBarItem(title: "Item3",
                       image: UIImage(named: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: false),
        HeroTabBarItem(title: "Item4",
                       image: UIImage(named: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                       isEmphasis: true)
    ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        navigationItem.titleView = titleView
        view.addSubview(tabBarBackView)
        view.addSubview(tabBarView)
        view.bringSubviewToFront(tabBarView)
        
        tabBarView.delegate = self
        tabBarView.itemViewList = tabBarItemList
        tabBarBackView.backgroundColor = .heroWhite100s
        
        tabBarBackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-66)
            make.height.equalTo(40)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(70)
        }
        
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
        
        tabBar.isHidden = true
        setupTabBarItems()
        
        tabChanged(tapped: 0)
    }
    
    private func setupTabBarItems() {
        let homeVC = ViewController()
        let homeItem = UITabBarItem(title: "", image: UIImage(named: "tab_home_un.png"), selectedImage: UIImage(named: "tab_home.png"))
        homeVC.tabBarItem = homeItem
        
        let secondVC = SecondViewController()
        let secondItem = UITabBarItem(title: "", image: UIImage(named: "tab_home_un.png"), selectedImage: UIImage(named: "tab_home.png"))
        secondVC.tabBarItem = secondItem
        
        // Append 4 VCs
        tabViewControllers.removeAll()
        tabViewControllers.append(homeVC)
        tabViewControllers.append(secondVC)
        tabViewControllers.append(homeVC)
        tabViewControllers.append(secondVC)
    }
    
    @objc
    private func tabChanged(tapped index: Int) {
        previousIndex = currentIndex
        currentIndex = index
        
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
    
    private func updateTabBarView() {
        self.view.layoutIfNeeded()
        
        if tabBarView.isSpread {
            tabBarView.snp.updateConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
            
            tabBarBackView.snp.updateConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        } else {
            tabBarView.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            }
            
            tabBarBackView.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-66)
            }
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
            self.tabBarView.borderRadius = self.tabBarView.isSpread ? 0 : 12
        })
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
        titleLabel.text = tabBarItemList[index].title
        tabChanged(tapped: index)
        
        if index == 3 {
            DebugLog("Action Button Clicked")
            updateTabBarView()
        } else {
            DebugLog("Normal Button Clicked")
            updateTabBarView()
        }
    }
}
