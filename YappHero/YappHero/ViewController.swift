//
//  ViewController.swift
//  YappHero
//
//  Created by Denny on 2021/02/20.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    private var helloLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(helloLabel)
        helloLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        helloLabel.text = "Hello World"
        helloLabel.font = .systemFont(ofSize: 14, weight: .regular)
        helloLabel.textColor = .black
    }
    
}

