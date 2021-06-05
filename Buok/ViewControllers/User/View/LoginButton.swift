//
//  LoginButton.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

public class LoginButton: UIButton {
    public enum LoginButtonType {
        case none
        case apple
        case google
        case kakao
    }
    
    public var loginButtonType: LoginButtonType = .none {
        didSet {
            setLoginButtonStyle()
        }
    }
    
    private let iconImageView: UIImageView = UIImageView()
    
    private func setLoginButtonStyle() {
        switch loginButtonType {
        case .none:
            self.backgroundColor = .heroServiceNavy
            self.setTitleColor(.heroWhite100s, for: .normal)
            self.iconImageView.isHidden = true
        case .apple:
            self.backgroundColor = .heroWhite100s
            self.setTitleColor(.heroGray5B, for: .normal)
            self.iconImageView.isHidden = false
            self.iconImageView.image = UIImage(heroSharedNamed: "ic_apple")
        case .google:
            self.backgroundColor = .heroWhite100s
            self.setTitleColor(.heroGray5B, for: .normal)
            self.iconImageView.isHidden = false
            self.iconImageView.image = UIImage(heroSharedNamed: "ic_google")
        case .kakao:
            self.backgroundColor = .heroYellowKakao
            self.setTitleColor(.heroGray5B, for: .normal)
            self.iconImageView.isHidden = false
            self.iconImageView.image = UIImage(heroSharedNamed: "ic_kakao")
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .heroServiceNavy
        self.layer.cornerRadius = 8
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    public func setHeroTitle(_ text: String) {
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [.font: UIFont.font17P, .foregroundColor: UIColor.white]), for: .normal)
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [.font: UIFont.font17P, .foregroundColor: UIColor.white]), for: .disabled)
    }
    
    public func setHeroEnable(_ value: Bool) {
        self.isEnabled = value
        self.backgroundColor = value ? .heroServiceNavy : .heroGrayA6A4A1
    }

}
