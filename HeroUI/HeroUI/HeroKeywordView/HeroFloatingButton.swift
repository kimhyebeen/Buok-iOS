//
//  HeroFloatingButton.swift
//  HeroUI
//
//  Copyright © 2021 Buok. All rights reserved.
//

import UIKit

public class HeroFloatingButton: UIButton {
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
        backgroundColor = .heroBlue100s
        layer.cornerRadius = addContentsButtonSize.height / 2
        
        if #available(iOS 13.0, *) {
            setImage(UIImage(named: "ic_right_arrow")?.withTintColor(.heroWhite100s), for: .normal)
        } else {
            setImage(UIImage(named: "ic_right_arrow"), for: .normal)
        }
    }

}
