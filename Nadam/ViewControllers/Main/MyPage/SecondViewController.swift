//
//  SecondViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/06.
//

import Foundation
import HeroCommon
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
        let alertController = HeroAlertController(rootViewController: self)
        alertController.setPositiveAction(action: HeroAlertAction(content: "확인", handler: {
            DebugLog("OK")
            self.sampleButton.setTitle("Sample Button(OK)", for: .normal)
        }))

        alertController.setNegativeAction(action: HeroAlertAction(content: "취소", handler: {
            DebugLog("Cancel")
            self.sampleButton.setTitle("Sample Button(Cancel)", for: .normal)
        }))

        alertController.showAlert(title: "샘플 타이틀", message: "샘플 텍스트입니다. 샘플 텍스트입니다.", buttonSetType: .okCancel)
    }
}
