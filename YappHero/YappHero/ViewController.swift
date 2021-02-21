//
//  ViewController.swift
//  YappHero
//
//  Created by Taein Kim on 2021/02/21.
//

import HeroCommon
import HeroUI
import SnapKit

class ViewController: UIViewController {
    private var heroButton: HeroButton = HeroButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(heroButton)
        
        heroButton.setTitle("Hello World", for: .normal)
        heroButton.titleLabel?.font = .font14PBold
        heroButton.setTitleColor(.heroBlue100s, for: .normal)
        heroButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        HeroLog.debug("Hello World")
    }


}

