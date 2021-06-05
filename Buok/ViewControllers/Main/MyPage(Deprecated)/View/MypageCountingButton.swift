//
//  MypageCountingButton.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import HeroUI

class MypageCountingButton: UIButton {
    private let countLabel = UILabel()
    private let mainLabel = UILabel()
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    var mainText: String = "" {
        didSet {
            mainLabel.text = mainText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupCountLabel()
        setupMainLabel()
    }

}

extension MypageCountingButton {
    // MARK: CountLabel
    private func setupCountLabel() {
        countLabel.text = "0"
        countLabel.textColor = .heroGray5B
        countLabel.font = .font17P // todo - 폰트 수정 필요
        self.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
    }
    
    // MARK: MainLabel
    private func setupMainLabel() {
        mainLabel.textColor = .heroGrayA6A4A1
        mainLabel.font = .font12P
        self.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
