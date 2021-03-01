//
//  SubOneViewController.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import HeroCommon
import HeroUI
import ObjectMapper
import RxSwift
import SnapKit

public class SubOneViewController: HeroBaseViewController {
    private var oneLabel: UILabel = UILabel()
    
    private var userUseCase: UserUseCase?
    private let disposeBag  = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userUseCase = UserUseCase()
        view.backgroundColor = .systemBlue
        view.addSubview(oneLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
        oneLabel.font = .font15PBold
        oneLabel.textColor = .white
        oneLabel.text = "111. One View Controller"
        
        self.userUseCase?.getAccessToken(refreshToken: "RefreshToken")
            .subscribe(onNext: { _, jsonString in
                let refreshResponse = TokenRefreshResponse(JSONString: jsonString)
                let accessToken = refreshResponse?.accessToken?.token!
                HeroLog.debug("AccessToken : \(accessToken ?? "nil")")
        }, onError: { error in
            HeroLog.debug("ERROR : \(error)")
        }).disposed(by: disposeBag)
    }
}
