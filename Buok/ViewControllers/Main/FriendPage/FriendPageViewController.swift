//
//  FriendPageViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroUI

class FriendPageViewController: HeroBaseViewController {
    let safeAreaView = UIView()
    let topView = UIView()
    let backButton = UIButton()
    let profileView = FriendPageProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupSafeAreaView()
        setupTopView()
        setupBackButton()
        setupProfileView()
        
        self.view.bringSubviewToFront(safeAreaView)
        self.view.bringSubviewToFront(topView)
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FriendPageViewController {
    // MARK: SafeAreaView
    func setupSafeAreaView() {
        safeAreaView.backgroundColor = .heroServiceSkin
        self.view.addSubview(safeAreaView)
        
        safeAreaView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    // MARK: TopView
    func setupTopView() {
        topView.backgroundColor = .heroServiceSkin
        self.view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(safeAreaView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: BackButton
    func setupBackButton() {
        if #available(iOS 13.0, *) {
            backButton.setImage(UIImage(heroSharedNamed: "ic_back")?.withTintColor(.heroGray82), for: .normal)
        } else {
            backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.topView.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.bottom.leading.equalToSuperview()
        }
    }
    
    // MARK: ProfileView
    func setupProfileView() {
        self.view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
