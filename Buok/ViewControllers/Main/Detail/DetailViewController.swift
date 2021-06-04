//
//  DetailViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class DetailViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let backButton: HeroImageButton = HeroImageButton()
    private let optionButton: HeroImageButton = HeroImageButton()
    private let menuButton: HeroImageButton = HeroImageButton()
    
    public var bucketItem: BucketModel? {
        didSet {
            let state = BucketState(rawValue: bucketItem?.bucketState ?? 0)
            if state == .done || state == .failure {
                optionButton.heroImage = UIImage(heroSharedNamed: "ic_mark")
            } else {
                optionButton.heroImage = UIImage(heroSharedNamed: "ic_pin")
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLayout()
        setupViewProperties()
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        topContentView.addSubview(backButton)
        topContentView.addSubview(optionButton)
        topContentView.addSubview(menuButton)

        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(44)
        }

        backButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }

        menuButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        optionButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(menuButton.snp.leading)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroGrayF2EDE8
        backButton.imageInset = 8
        backButton.heroImage = UIImage(heroSharedNamed: "ic_back")
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
        
        optionButton.imageInset = 8
        optionButton.heroImage = UIImage(heroSharedNamed: "ic_pin")
//        ic_mark / ic_pin
        
        menuButton.imageInset = 8
        menuButton.heroImage = UIImage(heroSharedNamed: "ic_menu_ver")
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
}
