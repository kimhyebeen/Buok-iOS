//
//  CreateViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class CreateViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let backButton: HeroImageButton = HeroImageButton()
    private let doneButton: HeroImageButton = HeroImageButton()
    private var viewModel: CreateViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLayout()
        setupViewProperties()
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        topContentView.addSubview(backButton)
        topContentView.addSubview(doneButton)

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

        doneButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroGraySample100s
        backButton.imageInset = 8
        backButton.heroImage = UIImage(heroSharedNamed: "tab_home.png")
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
}
