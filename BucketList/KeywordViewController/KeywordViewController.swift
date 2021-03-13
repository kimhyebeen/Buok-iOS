//
//  KeywordViewController.swift
//  BucketList
//
//  Created by 김혜빈 on 2021/03/11.
//

import HeroUI
import SnapKit

class KeywordViewController: UIViewController {
    private let textView = UITextView()
    private let button = UIButton()
    private let stackView = UIStackView()
    private let keywordRequest = KeywordRequest()

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
    
    func addKeywordToStackView(items: [KeywordItem]) {
        stackView.subviews.forEach({ subview in
            subview.removeFromSuperview()
        })
        
        for index in 0..<3 {
            if index >= items.count { break }
            let tag = TagView()
            tag.keyword = items[index].keyword
            self.stackView.addArrangedSubview(tag)
        }
    }
    
    @objc
    private func clickButton(_ sender: UIButton) {
        self.view.endEditing(true)
        keywordRequest.getKeywords(body: KeywordRequestBody(argument: KeywordRequestArgument(question: textView.text)))
            .then { [weak self] value in
                self?.addKeywordToStackView(items: value)
            }
    }

}

extension KeywordViewController {
    private func setupButton() {
        button.setTitle("키워드 추출", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        button.backgroundColor = .heroBlue100s
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        textView.translatesAutoresizingMaskIntoConstraints = false
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
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
