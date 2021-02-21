//
//  ViewController.swift
//  YappHero
//
//  Created by denny on 2021/02/21.
//

import SnapKit
import HeroUI

class ViewController: UIViewController {
    private var heroButton: HeroButton = HeroButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(heroButton)
    }


}

