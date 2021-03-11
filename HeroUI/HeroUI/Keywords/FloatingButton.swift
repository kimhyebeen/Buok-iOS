//
//  AddContentsButton.swift
//  HeroUI
//
//  Created by 김혜빈 on 2021/03/11.
//

import UIKit

class FloatingButton: UIButton {
    public var addContentsButtonSize = CGSize(width: 45, height: 45)
    public var image: UIImage? = UIImage(named: "ic_right_arrow") {
        didSet {
            if #available(iOS 13.0, *) {
                setImage(oldValue?.withTintColor(.heroWhite100s), for: .normal)
            } else {
                setImage(oldValue, for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .heroBlue100s
        layer.cornerRadius = addContentsButtonSize.height / 2
    }

}
