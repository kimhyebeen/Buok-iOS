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
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.setRightHeroBarButtonItem(
            UIBarButtonItem(image: UIImage(heroSharedNamed: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                            style: .plain,
                            target: self,
                            action: #selector(onClickSetting(_:))),
            animated: false)
        
        view.backgroundColor = .heroGraySample100s
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc
    private func onClickSetting(_ sender: Any) {
        
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
