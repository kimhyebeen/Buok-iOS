//
//  MypageViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import UIKit

class MypageViewController: HeroBaseViewController {
    let settingButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupSettingButton()
    }

    @objc
    func clickSettingButton(_ sender: UIButton) {
        // todo - 설정 버튼 기능
    }
    
}

extension MypageViewController {
    // MARK: SettingButton
    private func setupSettingButton() {
        if #available(iOS 13.0, *) {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!.withTintColor(.heroGray82), for: .normal)
        } else {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!, for: .normal)
        }
        settingButton.addTarget(self, action: #selector(clickSettingButton(_:)), for: .touchUpInside)
        self.view.addSubview(settingButton)
        
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
}
