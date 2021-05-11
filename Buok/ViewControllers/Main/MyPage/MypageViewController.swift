//
//  MypageViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import HeroUI

class MypageViewController: HeroBaseViewController {
    let settingButton = UIButton()
    let contentsView = MypageContentsView()
    let buokmarkHeader = MypageBuokmarkHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupSettingButton()
        setupContentsView()
        setupBuokmarkHeader()
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
    
    // MARK: ContentsView
    private func setupContentsView() {
        self.view.addSubview(contentsView)
        
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(settingButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: BuokmarkHeader
    private func setupBuokmarkHeader() {
        self.view.addSubview(buokmarkHeader)
        
        buokmarkHeader.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(contentsView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
