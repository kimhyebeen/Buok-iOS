//
//  SecondViewController.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/06.
//

import Foundation
import HeroUI
import SnapKit

public class SecondViewController: HeroBaseViewController {
    private let sampleButton: UIButton = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sampleButton)
        view.backgroundColor = .heroWhite100s
        
        sampleButton.setTitle("Sample Button", for: .normal)
        sampleButton.setTitleColor(.heroBlue100s, for: .normal)
        sampleButton.titleLabel?.font = .font16PBold
        sampleButton.addTarget(self, action: #selector(onClickSample(_:)), for: .touchUpInside)
        
        sampleButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc
    private func onClickSample(_ sender: UIButton) {
        let alertVC = HeroAlertController()
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.setTitle(title: "샘플 타이틀")
        alertVC.setDescription(description: "샘플 디스크립션입니다.샘플 디스크립션입니다.샘플 디스크립션입니다.")
        alertVC.buttonType = .okCancel
        alertVC.titleType = .full
        self.present(alertVC, animated: false, completion: nil)
    }
}
