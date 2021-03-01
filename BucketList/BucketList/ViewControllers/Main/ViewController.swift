//
//  ViewController.swift
//  YappHero
//
//  Created by Taein Kim on 2021/02/21.
//

import HeroCommon
import HeroUI
import SnapKit

class ViewController: HeroBaseViewController {
    private let scrollView        = UIScrollView()
    private let contentView       = UIView()
    private let mainStackView     = UIStackView()
    private let bottomFooterView  = UIView()
    private let bottomFooterLabel = UILabel()
    
    private let subOneVC = SubOneViewController()
    private let subTwoVC = SubTwoViewController()
    private let subThreeVC = SubThreeViewController()
    
    private var stackviewLeft: Constraint?
    private var stackviewRight: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        initViewLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshShadowLine(offset: scrollView.contentOffset.y)
    }
    
    public override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        stackviewLeft?.update(inset: view.safeAreaInsets.left)
        stackviewRight?.update(inset: view.safeAreaInsets.right)
    }
    
    private func initViewLayout() {
        mainStackView.subviews.forEach({ subview in
            subview.removeFromSuperview()
        })
        
        setContainerLayout()
        addSubViewControllers()
    }
    
    private func setContainerLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)

        scrollView.delegate = self.tabBarController as? UIScrollViewDelegate
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(250)
            make.width.equalToSuperview()
        }
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        
        contentView.addSubview(mainStackView)
        contentView.backgroundColor = .white
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        contentView.addSubview(bottomFooterView)
        bottomFooterView.addSubview(bottomFooterLabel)
        bottomFooterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        bottomFooterLabel.font = .font11P
        bottomFooterLabel.numberOfLines = 2
        bottomFooterLabel.textAlignment = .center
        bottomFooterLabel.textColor = UIColor(hex: "#9B9B9B")
        bottomFooterLabel.text = "YAPP iOS 1 Team 2021. All rights reserved."
        
        bottomFooterView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(116)
            make.top.greaterThanOrEqualTo(mainStackView.snp.bottom).offset(30)
        }
    }
    
    private func addSubViewControllers() {
        addChild(subOneVC)
        subOneVC.didMove(toParent: parent)
        mainStackView.addArrangedSubview(subOneVC.view)
        
        addChild(subTwoVC)
        subTwoVC.didMove(toParent: parent)
        mainStackView.addArrangedSubview(subTwoVC.view)
        
        addChild(subThreeVC)
        subThreeVC.didMove(toParent: parent)
        mainStackView.addArrangedSubview(subThreeVC.view)
    }
}

extension ViewController: HeroNavigationBarUpdatable { }
extension ViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshShadowLine(offset: scrollView.contentOffset.y)
    }
}
