//
//  CategoryFilterView.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/19.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

protocol BucketFilterDelegate: AnyObject {
    func filterChanged(filter to: BucketState)
}

class BucketFilterView: UIView {
    private let buttonContainerView: UIView = UIView()
    private let nowButton: HeroButton = HeroButton()
    private let expectButton: HeroButton = HeroButton()
    private let doneButton: HeroButton = HeroButton()
    private let allButton: HeroButton = HeroButton()
    
    private var homeFilter: BucketState = .now {
        didSet {
            updateButtonTextStyle()
            delegate?.filterChanged(filter: homeFilter)
        }
    }
    
    weak var delegate: BucketFilterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buttonContainerView.addSubview(nowButton)
        buttonContainerView.addSubview(expectButton)
        buttonContainerView.addSubview(doneButton)
        buttonContainerView.addSubview(allButton)
        
        nowButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        expectButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(nowButton.snp.trailing).offset(16)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(expectButton.snp.trailing).offset(16)
        }
        
        allButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(doneButton.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    private func setupViewProperties() {
        updateButtonTextStyle()
        nowButton.setTitle("Hero_Home_Filter_Now".localized, for: .normal)
        expectButton.setTitle("Hero_Home_Filter_Expect".localized, for: .normal)
        doneButton.setTitle("Hero_Home_Filter_Done".localized, for: .normal)
        allButton.setTitle("Hero_Home_Filter_All".localized, for: .normal)
        
        nowButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
        expectButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
        allButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
    }
    
    private func updateButtonTextStyle() {
        nowButton.titleLabel?.font = (homeFilter == .now) ? .font20PBold : .font20P
        nowButton.setTitleColor((homeFilter == .now) ? .heroGray5B : .heroGray82, for: .normal)
        
        expectButton.titleLabel?.font = (homeFilter == .expect) ? .font20PBold : .font20P
        expectButton.setTitleColor((homeFilter == .expect) ? .heroGray5B : .heroGray82, for: .normal)
        
        doneButton.titleLabel?.font = (homeFilter == .done) ? .font20PBold : .font20P
        doneButton.setTitleColor((homeFilter == .done) ? .heroGray5B : .heroGray82, for: .normal)
        
        allButton.titleLabel?.font = (homeFilter == .all) ? .font20PBold : .font20P
        allButton.setTitleColor((homeFilter == .all) ? .heroGray5B : .heroGray82, for: .normal)
    }
    
    @objc
    private func onClickFilterButton(_ sender: HeroButton) {
        switch sender {
        case nowButton:
            homeFilter = .now
        case expectButton:
            homeFilter = .expect
        case doneButton:
            homeFilter = .done
        case allButton:
            homeFilter = .all
        default:
            break
        }
    }
}
