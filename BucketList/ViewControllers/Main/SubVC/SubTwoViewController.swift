//
//  SubTwoViewController.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
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
