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
    private let floatingButton = FloatingButton()
    
    private let indicatorView: UIView = UIView()
    private let indicatorInnerView: UIView = UIView()
    
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
        
        setupMainLayout()
        setupViewProperties()
        setupTabBarItems()
        tabChanged(tapped: 0)
        setupFloatingButton()
    }
    
    private func setupMainLayout() {
        navigationItem.titleView = titleView
        view.addSubview(tabBarBackView)
        view.addSubview(tabBarView)
        view.bringSubviewToFront(tabBarView)
        tabBarView.addSubview(indicatorView)
        indicatorView.addSubview(indicatorInnerView)
        
        tabBarBackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(MainTabBarConstants.outerSpacing)
            make.trailing.equalToSuperview().offset(-MainTabBarConstants.outerSpacing)
            make.bottom.equalToSuperview().offset(-MainTabBarConstants.backOuterBottomSpacing)
            make.height.equalTo(MainTabBarConstants.backHeight)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(MainTabBarConstants.outerSpacing)
            make.trailing.equalToSuperview().offset(-MainTabBarConstants.outerSpacing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-MainTabBarConstants.outerSpacing)
            make.height.equalTo(MainTabBarConstants.tabBarHeight)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(MainTabBarConstants.indicatorHeight)
            make.width.equalTo(tabBarView.snp.height)
        }
        
        indicatorInnerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(MainTabBarConstants.indicatorInnerSpacing)
            make.trailing.equalToSuperview().offset(-MainTabBarConstants.indicatorInnerSpacing)
        }
        
        titleView.addSubview(titleLabel)
        titleView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupViewProperties() {
        self.delegate = self
        self.tabBar.isHidden = true
        
        tabBarView.delegate = self
        tabBarView.itemList = tabBarItemList
        
        indicatorInnerView.backgroundColor = .heroBlue100s
        indicatorInnerView.layer.cornerRadius = MainTabBarConstants.indicatorHeight / 2
        tabBarBackView.backgroundColor = .heroWhite100s
        
        titleLabel.font = .font17PBold
        titleLabel.textColor = .black
        titleLabel.text = "타이틀"
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
    
    private func setupFloatingButton() {
        floatingButton.addTarget(self, action: #selector(clickFloatingButton(_:)), for: .touchUpInside)
        self.view.addSubview(floatingButton)
        
        floatingButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.bottom.equalTo(tabBarView.snp.top).offset(-12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    @objc
    private func clickFloatingButton(_ sender: UIButton) {
        self.navigationController?.show(KeywordViewController(), sender: nil)
    }
    
    @objc
    private func tabChanged(tapped index: Int) {
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
        
        updateTabBarIndicatorView()
        
        self.view.bringSubviewToFront(floatingButton)
    }
    
    private func updateTabBarIndicatorView() {
        self.view.layoutIfNeeded()
        let spacingOffset = (tabBarView.frame.width - (tabBarView.frame.height * CGFloat(tabBarItemList.count))) / CGFloat(tabBarItemList.count - 1)
        let leadingOffset = (tabBarView.frame.height * CGFloat(currentIndex)) + spacingOffset * CGFloat(currentIndex)
        
        DebugLog("Spacing Offset : \(spacingOffset)")
        DebugLog("Leading Offset : \(leadingOffset)")
        
        if currentIndex == (tabBarItemList.count - 1) {
            indicatorView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(MainTabBarConstants.indicatorHeight)
                make.width.equalTo(tabBarView.snp.height)
                make.trailing.equalToSuperview()
            }
        } else {
            indicatorView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(MainTabBarConstants.indicatorHeight)
                make.width.equalTo(tabBarView.snp.height)
                make.leading.equalToSuperview().offset(leadingOffset)
            }
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
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
                make.leading.equalToSuperview().offset(MainTabBarConstants.outerSpacing)
                make.trailing.equalToSuperview().offset(-MainTabBarConstants.outerSpacing)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-MainTabBarConstants.outerSpacing)
            }
            
            tabBarBackView.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(MainTabBarConstants.outerSpacing)
                make.trailing.equalToSuperview().offset(-MainTabBarConstants.outerSpacing)
                make.bottom.equalToSuperview().offset(-MainTabBarConstants.backOuterBottomSpacing)
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
            updateTabBarView()
        } else {
            updateTabBarView()
        }
    }
}
