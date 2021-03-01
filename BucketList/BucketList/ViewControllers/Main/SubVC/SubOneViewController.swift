//
//  SubOneViewController.swift
//  BucketList
//
//  Created by denny on 2021/03/01.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class SubOneViewController: HeroBaseViewController {
    private var oneLabel: UILabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        view.addSubview(oneLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
        oneLabel.font = .font15PBold
        oneLabel.textColor = .white
        oneLabel.text = "111. One View Controller"
    }
}
