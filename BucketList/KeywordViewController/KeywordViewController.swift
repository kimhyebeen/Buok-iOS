//
//  KeywordViewController.swift
//  BucketList
//
//  Created by 김혜빈 on 2021/03/11.
//

import HeroUI
import SnapKit

class KeywordViewController: UIViewController {
    private var textView = UITextView()
    private var button = UIButton()
    private var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .heroWhite100s
        self.title = "키워드"
        setupButton()
        setupTextField()
        setupStackView()
    }
    
    func addKeywordToStackView() {
        stackView.subviews.forEach({ subview in
            subview.removeFromSuperview()
        })
        
        // todo - add keyword to stack view
    }

}

extension KeywordViewController {
    private func setupButton() {
        button.setTitle("키워드 추출", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        button.backgroundColor = .heroBlue100s
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTextField() {
        textView.text = ""
        textView.font = .font14P
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray.cgColor
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.bottom.equalTo(button.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setupStackView() {
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
}
