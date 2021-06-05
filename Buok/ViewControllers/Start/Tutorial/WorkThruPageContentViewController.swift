//
//  WorkThruPageContentViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import Lottie
import SnapKit
import UIKit

final class WorkThruPageContentViewController: UIViewController {
    enum ContentType: Int {
        case first
        case second
        case third
        case fourth
    }
    
    private let contentType: ContentType
    private let pageIndex: Int
    
    private let titleLabel = UILabel()
    private let imageContentView = UIImageView()
    
    private var gradientLayer: CAGradientLayer!
    
    init(pageIndex: Int) {
        guard pageIndex < 4 else {
            fatalError("WorkThruPageContentViewController pageIndex must be lower then 3")
        }
        self.pageIndex = pageIndex
        self.contentType = ContentType(rawValue: pageIndex)! // 2 이상 넘어가면 크래시남 전체 페이지는 3개 max
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageContentView)
        view.addSubview(titleLabel)
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.heroGrayC7BFB8, UIColor.heroGrayF2EDE8]
        self.view.layer.addSublayer(self.gradientLayer)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-131)
            make.height.equalTo(72)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.centerX.equalToSuperview()
        }
        
        imageContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(130)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.centerX.equalToSuperview()
            make.height.equalTo(240)
        }
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.numberOfLines = 0
        
        titleLabel.textColor = .heroGray5B
        titleLabel.textAlignment = .center
        
        imageContentView.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch contentType {
        case .first:
            titleLabel.text = "안녕하세요. 반갑습니다.\nBuok [북] 은 현재를 함께하며\n미래를 만들어가는 공간입니다."
            imageContentView.image = UIImage(heroSharedNamed: "ic_stage_1")
        case .second:
            titleLabel.text = "생각날 때마다 미래 계획을 담은\n버킷북을 만들어보세요\n그리고 친구와 공유해보세요."
            imageContentView.image = UIImage(heroSharedNamed: "ic_stage_2")
        case .third:
            titleLabel.text = "완성된 버킷북\n나를 잘 나타내는 것을 골라서\n히스토리로 만들어보세요."
            imageContentView.image = UIImage(heroSharedNamed: "ic_stage_3")
        case .fourth:
            titleLabel.text = "이렇게 저희와 함께하다 보면\n당신의 꿈이 이뤄져 있을거에요.\n이제 북을 만들어볼까요?"
            imageContentView.image = UIImage(heroSharedNamed: "ic_stage_4")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}
