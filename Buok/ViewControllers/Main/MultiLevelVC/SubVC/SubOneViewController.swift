//
//  SubOneViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/01.
//

import Alamofire
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
        
//		BucketListAPIRequest.bucketListRequest(bucketState: "ALL", category: "ALL", sort: "1")
//		UserAPIRequest.usersListRequest()
		UserAPIRequest.usersmeListRequest()
    }
}
