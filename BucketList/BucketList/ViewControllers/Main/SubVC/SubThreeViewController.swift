//
//  SubThreeViewController.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
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
