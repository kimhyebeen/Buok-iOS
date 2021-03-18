//
//  HomeViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class HomeViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let notiButton: HeroImageButton = HeroImageButton()
    private let searchButton: HeroImageButton = HeroImageButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupMainLayout()
        setupViewProperties()
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        topContentView.addSubview(notiButton)
        topContentView.addSubview(searchButton)
        
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(44)
        }
        
        notiButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroWhite100s
        notiButton.heroImage = UIImage(heroSharedNamed: "tab_home.png")
        searchButton.heroImage = UIImage(heroSharedNamed: "tab_home.png")
    }
}
