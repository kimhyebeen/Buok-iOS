//
//  DetailViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class DetailViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let backButton: HeroImageButton = HeroImageButton()
    private let optionButton: HeroImageButton = HeroImageButton()
    private let menuButton: HeroImageButton = HeroImageButton()
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let contentStackView: UIStackView = UIStackView()
    private let contentContainerView: UIView = UIView()
    private let historyContainerView: UIView = UIView()
    
    private let stateView: UIView = UIView()
    private let stateLabel: UILabel = UILabel()
    
    private let categoryView: UIView = UIView()
    private let categoryLabel: UILabel = UILabel()
    
    private let titleLabel: UILabel = UILabel()
    private let bottomBar: UIView = UIView()
    
    private let clockImageView: UIImageView = UIImageView()
    private let dateLabel: UILabel = UILabel()
    
    private let contentBackgroundView: UIView = UIView()
    private let contentTextView: UITextView = UITextView()
    
    public var bucketItem: BucketModel? {
        didSet {
            let state = BucketState(rawValue: bucketItem?.bucketState ?? 0)
            if state == .done || state == .failure {
                optionButton.heroImage = UIImage(heroSharedNamed: "ic_mark")
            } else {
                optionButton.heroImage = UIImage(heroSharedNamed: "ic_pin")
            }
            
            setContentData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLayout()
        setupViewProperties()
    }
    
    private func setContentData() {
        let state = BucketState(rawValue: bucketItem?.bucketState ?? 0)
        let category = BucketCategory(rawValue: (bucketItem?.categoryId ?? 2) - 2)
        var bgColor: UIColor?
        
        stateLabel.text = state?.getTitle()
        categoryLabel.text = category?.getTitle()
        
        switch state {
        case .now:
            bgColor = .heroServiceNavy
        case .expect:
            bgColor = .heroPrimaryBlue
        case .done:
            bgColor = .heroPrimaryPink
        case .failure:
            bgColor = .heroPrimaryPink
        default:
            break
        }
        
        stateView.backgroundColor = bgColor
        categoryView.backgroundColor = .heroGray5B
        
        titleLabel.text = bucketItem?.bucketName ?? ""
        dateLabel.text = bucketItem?.endDate.convertToDate().convertToKoreanString()
        
        contentTextView.text = "서버 연동 필요"
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        topContentView.addSubview(backButton)
        topContentView.addSubview(optionButton)
        topContentView.addSubview(menuButton)
        
        view.addSubview(scrollView)
        scrollView.delegate = self.tabBarController as? UIScrollViewDelegate
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(contentView)

        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(44)
        }

        backButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }

        menuButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        optionButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(menuButton.snp.leading)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-2)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(250)
            make.width.equalToSuperview()
        }
        
        contentView.addSubview(contentStackView)
        contentView.backgroundColor = .heroGrayF2EDE8
        
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(contentContainerView)
        contentStackView.addArrangedSubview(historyContainerView)
        
        contentContainerView.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
        
        historyContainerView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
        
        // MARK: Content Layout
        contentContainerView.addSubview(stateView)
        stateView.addSubview(stateLabel)
        
        contentContainerView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        
        stateView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(44)
            make.height.equalTo(32)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalTo(stateView.snp.trailing).offset(12)
            make.width.equalTo(44)
            make.height.equalTo(32)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(bottomBar)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stateView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        bottomBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
        }
        
        contentContainerView.addSubview(clockImageView)
        contentContainerView.addSubview(dateLabel)
        
        clockImageView.snp.makeConstraints { make in
            make.top.equalTo(bottomBar.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(clockImageView.snp.centerY)
            make.leading.equalTo(clockImageView.snp.trailing).offset(7)
        }
        
        contentContainerView.addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(contentTextView)
        
        contentBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(clockImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroGrayF2EDE8
        backButton.imageInset = 8
        backButton.heroImage = UIImage(heroSharedNamed: "ic_back")
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
        
        optionButton.imageInset = 8
        optionButton.heroImage = UIImage(heroSharedNamed: "ic_pin")
//        ic_mark / ic_pin
        
        menuButton.imageInset = 8
        menuButton.heroImage = UIImage(heroSharedNamed: "ic_menu_ver")
        
        scrollView.showsVerticalScrollIndicator = false
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        
        [contentContainerView, historyContainerView].forEach {
            $0.backgroundColor = .heroWhite100s
            $0.layer.cornerRadius = 16
        }
        
        historyContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [stateLabel, categoryLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.textColor = .heroWhite100s
            $0.textAlignment = .center
        }
        
        [stateView, categoryView].forEach {
            $0.layer.cornerRadius = 8
        }
        
        bottomBar.backgroundColor = .heroGrayF1F1F1
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .heroGray5B
        
        clockImageView.image = UIImage(heroSharedNamed: "ic_clock")
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        dateLabel.textColor = .heroGray5B
        
        contentBackgroundView.layer.cornerRadius = 7
        contentBackgroundView.backgroundColor = .heroGrayF2EDE8
        contentTextView.isEditable = false
        contentTextView.textColor = .heroGray5B
        contentTextView.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
}
