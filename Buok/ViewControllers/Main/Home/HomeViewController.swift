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
    let topContentView: UIView = UIView()
    let notiButton: HeroImageButton = {
        $0.imageInset = 8
        $0.heroImage = UIImage(heroSharedNamed: "ic_noti")
        $0.addTarget(self, action: #selector(onClickNotification(_:)), for: .touchUpInside)
        return $0
    }(HeroImageButton())
    
    let searchButton: HeroImageButton = {
        $0.imageInset = 8
        $0.heroImage = UIImage(heroSharedNamed: "ic_search")
        $0.addTarget(self, action: #selector(onClickSearch(_:)), for: .touchUpInside)
        return $0
    }(HeroImageButton())
    
    let topSectionView: UIStackView = UIStackView()
    let filterContainerView: UIView = UIView()
    let messageContainerView: UIView = UIView()
    let bucketFilterView: BucketFilterView = BucketFilterView()
    
    // MARK: Speech Bubble
    let bucketCountBubble: UIView = UIView()
    let bubbleTriangleView: UIImageView = UIImageView()
    let countDescLabel: UILabel = UILabel()
    
    // MARK: Category
    let categoryContainerView: UIView = UIView()
    let categoryButton: HeroButton = HeroButton()
    let categoryTitleLabel: UILabel = UILabel()
    let categoryImageView: UIImageView = UIImageView()
    let categoryDeleteButton: UIButton = UIButton()
    
    var currentFilter: HomeFilter = .now
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
    
    func bindViewModel() {
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
    
    func applyCurrentFilter(filter: HomeFilter) {
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
    
    func applyAttributedBubbleText(count: Int, filter: HomeFilter) {
        countDescLabel.attributedText = generateAttributedText(count: count, filter: filter)
    }
    
    func generateAttributedText(count: Int, filter: HomeFilter) -> NSMutableAttributedString? {
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
    
    @objc
    func onClickCategoryDeleteButton(_ sender: Any?) {
        viewModel?.bucketCategory.value = .noCategory
    }
    
    @objc
    func onClickCategoryFilterButton(_ sender: Any?) {
        let selectVC = HeroSelectViewController()
        
        selectVC.titleContent = "카테고리 선택"
        selectVC.modalPresentationStyle = .overCurrentContext
        selectVC.itemList = viewModel?.categoryItemList ?? [HeroSelectItem]()
        selectVC.delegate = self
        self.present(selectVC, animated: false, completion: nil)
    }
    
    @objc
    func onClickNotification(_ sender: Any?) {
        navigationController?.pushViewController(MultiLevelViewController(), animated: true)
    }
    
    @objc
    func onClickSearch(_ sender: Any?) {
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
