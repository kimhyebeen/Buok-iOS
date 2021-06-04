//
//  BucketStateView.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/04.
//

import Foundation
import HeroCommon
import HeroUI

final class BucketStateView: UIView {
    public var state: BucketState = .now {
        didSet {
            updateProperty(state: state)
        }
    }
    
    private let stateTopView: UIView = UIView()
    private let stateBottomView: UIView = UIView()
    private let stateLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        addSubview(stateTopView)
        addSubview(stateBottomView)
        addSubview(stateLabel)
        
        stateTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        stateBottomView.snp.makeConstraints { make in
            make.top.equalTo(stateTopView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        stateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        
        stateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        stateLabel.textColor = .heroWhite100s
        
        stateTopView.layer.cornerRadius = 2
        stateTopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        stateBottomView.layer.cornerRadius = 6
        stateBottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    private func updateProperty(state: BucketState) {
        var bgColor: UIColor?
        switch state {
        case .now:
            bgColor = .heroServiceNavy
            stateLabel.text = "진행"
        case .expect:
            bgColor = .heroPrimaryBlue
            stateLabel.text = "예정"
        case .done:
            bgColor = .heroPrimaryPink
            stateLabel.text = "완료"
        case .failure:
            bgColor = .heroPrimaryPink
            stateLabel.text = "실패"
        case .all:
            break
        }
        
        stateTopView.backgroundColor = bgColor
        stateBottomView.backgroundColor = bgColor
    }
}
