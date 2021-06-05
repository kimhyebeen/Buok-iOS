//
//  SubTwoViewController.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class SubTwoViewController: HeroBaseViewController {
    private var twoLabel: UILabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        view.addSubview(twoLabel)
        
        twoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(480)
        }
        twoLabel.font = .font15PBold
        twoLabel.textColor = .white
        twoLabel.text = "222. Two View Controller"
    }
}
