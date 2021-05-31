//
//  HomeViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class HomeViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let notiButton: HeroImageButton = {
        $0.imageInset = 8
        $0.heroImage = UIImage(heroSharedNamed: "ic_noti")
        $0.addTarget(self, action: #selector(onClickNotification(_:)), for: .touchUpInside)
        return $0
    }(HeroImageButton())
    
    private let searchButton: HeroImageButton = {
        $0.imageInset = 8
        $0.heroImage = UIImage(heroSharedNamed: "ic_search")
        $0.addTarget(self, action: #selector(onClickSearch(_:)), for: .touchUpInside)
        return $0
    }(HeroImageButton())
    
    private let topSectionView: UIStackView = UIStackView()
    private let filterContainerView: UIView = UIView()
    private let messageContainerView: UIView = UIView()
    private let bucketFilterView: BucketFilterView = BucketFilterView()
    
    // MARK: Speech Bubble
    private let bucketCountBubble: UIView = UIView()
    private let bubbleTriangleView: UIImageView = UIImageView()
    private let countDescLabel: UILabel = UILabel()
    
    // MARK: Category
    private let categoryContainerView: UIView = UIView()
    private let categoryButton: HeroButton = HeroButton()
    private let categoryTitleLabel: UILabel = UILabel()
    private let categoryImageView: UIImageView = UIImageView()
    private let categoryDeleteButton: UIButton = UIButton()
    
    private var currentFilter: HomeFilter = .now
    public var viewModel: HomeViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        bindViewModel()
        setupMainLayout()
        setupViewProperties()
		notiButton.addTarget(self, action: #selector(onClickNotification(_:)), for: .touchUpInside)
        
        viewModel?.bucketCategory.value = .noCategory
        viewModel?.filterChanged(filter: .now)
        messageContainerView.isHidden = false
//        viewModel?.refreshToken()
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.currentFilter.bind({ [weak self] filter in
                self?.applyCurrentFilter(filter: filter)
            })
            
            viewModel.bucketCount.bind({ [weak self] count in
                self?.applyAttributedBubbleText(count: count, filter: viewModel.currentFilter.value)
            })
            
            viewModel.bucketCategory.bind({ [weak self] category in
                if category != .noCategory {
                    self?.categoryDeleteButton.isEnabled = true
                    self?.messageContainerView.isHidden = true
                    self?.categoryTitleLabel.text = category.getTitle()
                    self?.categoryImageView.image = UIImage(heroSharedNamed: "ic_category_delete")
                } else {
                    self?.categoryDeleteButton.isEnabled = false
                    self?.messageContainerView.isHidden = (viewModel.currentFilter.value == .all) || false
                    self?.categoryTitleLabel.text = "카테고리"
                    self?.categoryImageView.image = UIImage(heroSharedNamed: "ic_narrow_12")
                }
            })
        }
    }
    
    private func applyCurrentFilter(filter: HomeFilter) {
        var leadingOffset = 0
        applyAttributedBubbleText(count: viewModel?.bucketCount.value ?? 0, filter: filter)
        
        switch filter {
        case .now:
            leadingOffset = 13
        case .expect:
            leadingOffset = 63
        case .done:
            leadingOffset = 113
        case .all:
            break
        }
        
        DebugLog("Message Hidden(Filter Changed)")
        DebugLog("filter == .all : \(filter == .all)")
        DebugLog("viewModel?.bucketCategory != nil : \(viewModel?.bucketCategory != nil)")
        
        let category = viewModel?.bucketCategory.value ?? .noCategory
        messageContainerView.isHidden = (filter == .all) || (category != BucketCategory.noCategory)
        bubbleTriangleView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(leadingOffset)
        }
    }
    
    private func applyAttributedBubbleText(count: Int, filter: HomeFilter) {
        countDescLabel.attributedText = generateAttributedText(count: count, filter: filter)
    }
    
    private func generateAttributedText(count: Int, filter: HomeFilter) -> NSMutableAttributedString? {
        let countText = count < 10 ? "0\(count)" : "\(count)"
        
        switch filter {
        case .now:
            let text = "\(countText)" + "개의 버킷북을 가지고 있어요!"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: (text as NSString).range(of: "02"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: "02"))
            return attributedStr
        case .expect:
            let text = "\(countText)" + "개의 버킷북을 계획 중이에요"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: (text as NSString).range(of: "02"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: "02"))
            return attributedStr
        case .done:
            let text = "\(countText)" + "개의 버킷북 완료했어요"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: (text as NSString).range(of: "02"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.heroPrimaryPink, range: (text as NSString).range(of: "02"))
            return attributedStr
        case .all:
            return nil
        }
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        view.addSubview(topSectionView)
        topContentView.addSubview(notiButton)
        topContentView.addSubview(searchButton)
        
        // Top Filter Section
        topSectionView.addArrangedSubview(filterContainerView)
        topSectionView.addArrangedSubview(messageContainerView)
        filterContainerView.addSubview(bucketFilterView)
        filterContainerView.addSubview(categoryContainerView)
        
        // Category Button
        categoryContainerView.addSubview(categoryTitleLabel)
        categoryContainerView.addSubview(categoryImageView)
        categoryContainerView.addSubview(categoryButton)
        categoryContainerView.bringSubviewToFront(categoryButton)
        
        categoryContainerView.addSubview(categoryDeleteButton)
        
        messageContainerView.addSubview(bubbleTriangleView)
        messageContainerView.addSubview(bucketCountBubble)
        bucketCountBubble.addSubview(countDescLabel)
        
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(48)
        }
        
        notiButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7)
            make.centerY.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-7)
            make.centerY.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        // Top Filter Section
        topSectionView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        filterContainerView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        bucketFilterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Category Button
        categoryContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(categoryTitleLabel.snp.trailing).offset(2)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        categoryDeleteButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(categoryImageView.snp.leading)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupBubbleLayout()
    }
    
    private func setupBubbleLayout() {
        bucketCountBubble.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        bubbleTriangleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(22.93)
            make.height.equalTo(19)
            make.bottom.equalTo(bucketCountBubble.snp.top).offset(3)
            make.leading.equalToSuperview().offset(13)
        }
        
        countDescLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroGrayF2EDE8
        
        topSectionView.axis = .vertical
        messageContainerView.backgroundColor = .clear
        bucketFilterView.delegate = self
        
        bucketCountBubble.layer.cornerRadius = 7
        bucketCountBubble.backgroundColor = .heroPrimaryNavyLight
        bubbleTriangleView.image = UIImage(heroSharedNamed: "ic_bubble_triangle")
        
        countDescLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        countDescLabel.textColor = .heroWhite100s
        
        categoryContainerView.backgroundColor = .heroWhite100s
        categoryContainerView.layer.cornerRadius = 8
        
        categoryTitleLabel.text = "Hero_Common_Category".localized
        categoryTitleLabel.font = .font15P
        categoryTitleLabel.textColor = .heroGray82
        categoryButton.addTarget(self, action: #selector(onClickCategoryFilterButton(_:)), for: .touchUpInside)
        categoryImageView.image = UIImage(heroSharedNamed: "ic_narrow_12")
        
        categoryDeleteButton.isEnabled = false
        categoryDeleteButton.addTarget(self, action: #selector(onClickCategoryDeleteButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickCategoryDeleteButton(_ sender: Any?) {
        viewModel?.bucketCategory.value = .noCategory
    }
    
    @objc
    private func onClickCategoryFilterButton(_ sender: Any?) {
        let selectVC = HeroSelectViewController()
        
        selectVC.titleContent = "카테고리 선택"
        selectVC.modalPresentationStyle = .overCurrentContext
        selectVC.itemList = viewModel?.categoryItemList ?? [HeroSelectItem]()
        selectVC.delegate = self
        self.present(selectVC, animated: false, completion: nil)
    }
    
    @objc
    private func onClickNotification(_ sender: Any?) {
        navigationController?.pushViewController(MultiLevelViewController(), animated: true)
    }
    
    @objc
    private func onClickSearch(_ sender: Any?) {
        navigationController?.pushViewController(MultiLevelViewController(), animated: true)
    }
}

extension HomeViewController: HeroSelectViewDelegate {
    public func selectViewCloseClicked(viewController: HeroSelectViewController) {
        viewController.dismiss(animated: false, completion: nil)
    }
    
    public func selectViewItemSelected(viewController: HeroSelectViewController, selected index: Int) {
        viewModel?.bucketCategory.value = BucketCategory(rawValue: index) ?? .noCategory
        viewController.dismiss(animated: false, completion: nil)
    }
}

extension HomeViewController: BucketFilterDelegate {
    func filterChanged(filter to: HomeFilter) {
        if currentFilter != to {
            currentFilter = to
            viewModel?.filterChanged(filter: to)
        }
    }
}
