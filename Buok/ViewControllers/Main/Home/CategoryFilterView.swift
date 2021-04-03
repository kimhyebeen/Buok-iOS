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

protocol BucketFilterDelegate: class {
    func filterChanged(filter to: HomeFilter)
}

class BucketFilterView: UIView {
    private let buttonContainerView: UIView = UIView()
    private let nowButton: HeroButton = HeroButton()
    private let expectButton: HeroButton = HeroButton()
    private let doneButton: HeroButton = HeroButton()
    private let allButton: HeroButton = HeroButton()
    
    private var homeFilter: HomeFilter = .now {
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
            make.leading.equalTo(nowButton.snp.trailing).offset(8)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(expectButton.snp.trailing).offset(8)
        }
        
        allButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(doneButton.snp.trailing).offset(8)
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
        nowButton.titleLabel?.font = (homeFilter == .now) ? .font17PBold : .font17P
        nowButton.setTitleColor((homeFilter == .now) ? .heroGray600s : .heroGraySample300s, for: .normal)
        
        expectButton.titleLabel?.font = (homeFilter == .expect) ? .font17PBold : .font17P
        expectButton.setTitleColor((homeFilter == .expect) ? .heroGray600s : .heroGraySample300s, for: .normal)
        
        doneButton.titleLabel?.font = (homeFilter == .done) ? .font17PBold : .font17P
        doneButton.setTitleColor((homeFilter == .done) ? .heroGray600s : .heroGraySample300s, for: .normal)
        
        allButton.titleLabel?.font = (homeFilter == .all) ? .font17PBold : .font17P
        allButton.setTitleColor((homeFilter == .all) ? .heroGray600s : .heroGraySample300s, for: .normal)
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
