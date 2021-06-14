//
//  FriendButton.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroCommon
import UIKit

enum FriendButtonType {
    case friend
    case request
    case none
}

class FriendButton: UIButton {
	
	var friendType: Dynamic<FriendButtonType> = Dynamic(.none)
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.setAttributedTitle(NSAttributedString(string: "Hero_Profile_Friend".localized, attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.white]), for: .normal)
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = UIColor.heroGray5B.cgColor
    }
    
    func settingFriendButtonType(for type: FriendButtonType) {
        if type == .friend {
            settingFriendMode()
			friendType.value = .friend
        } else if type == .request {
            settingRequestFriendMode()
			friendType.value = .request
        } else {
            settingNotFriendMode()
			friendType.value = .none
        }
    }
    
    private func settingFriendMode() {
        let textOfButton = "Hero_Profile_Friend".localized
        self.setAttributedTitle(NSAttributedString(string: textOfButton, attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.white]), for: .normal)
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor.heroGray5B.cgColor
    }
    
    private func settingRequestFriendMode() {
        let textOfButton = "Hero_Profile_Request_Cancel".localized
        self.setAttributedTitle(NSAttributedString(string: textOfButton, attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.heroGray82]), for: .normal)
        self.layer.borderWidth = 1
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderColor = UIColor.heroGray82.cgColor
    }
    
    private func settingNotFriendMode() {
        let textOfButton = "Hero_Profile_Request".localized
        self.setAttributedTitle(NSAttributedString(string: textOfButton, attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.heroGray82]), for: .normal)
        self.layer.borderWidth = 1
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderColor = UIColor.heroGray82.cgColor
    }
}
