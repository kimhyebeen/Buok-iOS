//
//  HeroImageButton.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import SnapKit
import UIKit

public class HeroImageButton: UIButton {
    private let heroImageView: UIImageView = UIImageView()
    public var imageInset: CGFloat = 0 {
        didSet {
            heroImageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(imageInset)
                make.bottom.equalToSuperview().offset(-imageInset)
                make.leading.equalToSuperview().offset(imageInset)
                make.trailing.equalToSuperview().offset(-imageInset)
            }
        }
    }
    
    public var heroImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.heroImageView.image = self.heroImage?.withRenderingMode(.alwaysTemplate)
                self.heroImageView.tintColor = .heroGraySample300s
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainLayout() {
        addSubview(heroImageView)
        heroImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(imageInset)
            make.bottom.equalToSuperview().offset(-imageInset)
            make.leading.equalToSuperview().offset(imageInset)
            make.trailing.equalToSuperview().offset(-imageInset)
        }
    }
}
