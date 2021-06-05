//
//  SubThreeViewController.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class SubThreeViewController: HeroBaseViewController {
    private var threeLabel: UILabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        view.addSubview(threeLabel)
        
        threeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(240)
        }
        threeLabel.font = .font15PBold
        threeLabel.textColor = .white
        threeLabel.text = "333. Three View Controller"
    }
}
