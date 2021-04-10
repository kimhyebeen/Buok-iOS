//
//  MyPageViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/03/06.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class MyPageViewController: HeroBaseViewController {
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    private let profileView: MyPageProfileView = MyPageProfileView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        if let navBar = navigationController?.navigationBar as? HeroUINavigationBar {
            navBar.tintColor = .heroGray600s
            navBar.barTintColor = .heroGraySample100s
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setRightHeroBarButtonItem(
            UIBarButtonItem(image: UIImage(heroSharedNamed: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                            style: .plain,
                            target: self,
                            action: #selector(onClickSetting(_:))),
            animated: false)
        
        view.backgroundColor = .heroGraySample100s
        setupViewLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc
    private func onClickSetting(_ sender: Any) {
        
    }
    
    private func setupViewLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(250)
            make.width.equalToSuperview()
        }
        
        contentView.backgroundColor = .heroGraySample100s
        contentView.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
//    @objc
//    private func onClickSample(_ sender: UIButton) {
//        let alertController = HeroAlertController(rootViewController: self)
//        alertController.setPositiveAction(action: HeroAlertAction(content: "확인", handler: {
//            DebugLog("OK")
//            self.sampleButton.setTitle("Sample Button(OK)", for: .normal)
//        }))
//
//        alertController.setNegativeAction(action: HeroAlertAction(content: "취소", handler: {
//            DebugLog("Cancel")
//            self.sampleButton.setTitle("Sample Button(Cancel)", for: .normal)
//        }))
//
//        alertController.showAlert(title: "샘플 타이틀", message: "샘플 텍스트입니다. 샘플 텍스트입니다.", buttonSetType: .okCancel)
//    }
}
