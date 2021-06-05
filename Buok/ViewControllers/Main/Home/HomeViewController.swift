//
//  HomeViewController.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
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
    
    // MARK: Total Info & Sort View
    let totalContainerView: UIView = UIView()
    let totalLabel: UILabel = UILabel()
    let sortContainerView: UIView = UIView()
    let sortLabel: UILabel = UILabel()
    let sortImageView: UIImageView = UIImageView()
    let sortButton: UIButton = UIButton()
    
    // MARK: Category
    let categoryContainerView: UIView = UIView()
    let categoryButton: HeroButton = HeroButton()
    let categoryTitleLabel: UILabel = UILabel()
    let categoryImageView: UIImageView = UIImageView()
    let categoryDeleteButton: UIButton = UIButton()
    
    let bucketCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var currentFilter: BucketState = .now
    public var viewModel: HomeViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        bindViewModel()
        setupMainLayout()
        setupViewProperties()
        
        viewModel?.bucketCategory.value = .noCategory
        viewModel?.bucketSort.value = .created
        
        viewModel?.filterChanged(filter: .now)
        messageContainerView.isHidden = false
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchBucketList()
    }
    
    func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.currentFilter.bind({ [weak self] filter in
                self?.applyCurrentFilter(filter: filter)
                self?.viewModel?.fetchBucketList()
            })
            
            viewModel.bucketCount.bind({ [weak self] count in
                self?.applyAttributedBubbleText(count: count, filter: viewModel.currentFilter.value)
                self?.applyAttributedTotalText(count: count)
            })
            
            viewModel.bucketSort.bind({ [weak self] sort in
                // MARK: Sort 변경 시 처리하는 부분입니다.
                self?.sortLabel.text = sort.getTitle()
                self?.viewModel?.fetchBucketList()
            })
            
            viewModel.bucketList.bind({ [weak self] _ in
                self?.bucketCollectionView.reloadData()
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
                self?.viewModel?.fetchBucketList()
            })
        }
    }
    
    func applyCurrentFilter(filter: BucketState) {
        var leadingOffset = 0
        applyAttributedBubbleText(count: viewModel?.bucketCount.value ?? 0, filter: filter)
        
        switch filter {
        case .now:
            leadingOffset = 13
        case .expect:
            leadingOffset = 63
        case .done:
            leadingOffset = 113
        case.failure:
            break
        case .all:
            break
        }
        
        DebugLog("Message Hidden(Filter Changed)")
        DebugLog("filter == .all : \(filter == .all)")
        DebugLog("viewModel?.bucketCategory != nil : \(viewModel?.bucketCategory != nil)")
        
        let category = viewModel?.bucketCategory.value ?? .noCategory
        messageContainerView.isHidden = (filter == .all) || (category != BucketCategory.noCategory)
        totalContainerView.isHidden = !(filter == .all)
        
        bubbleTriangleView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(leadingOffset)
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
    func onClickSortButton(_ sender: Any?) {
        DebugLog("Sort Button Clicked")
        showSortAlert()
    }
    
    @objc
    func onClickNotification(_ sender: Any?) {
        navigationController?.pushViewController(MultiLevelViewController(), animated: true)
    }
    
    @objc
    func onClickSearch(_ sender: Any?) {
        let vc = SearchViewController()
        vc.viewModel = SearchViewModel()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func showSortAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let byCreatedAt = UIAlertAction(title: "작성순", style: .default, handler: { _ in
            self.viewModel?.bucketSort.value = .created
        })
        
        let byCharacter = UIAlertAction(title: "가나다순", style: .default, handler: { _ in
            self.viewModel?.bucketSort.value = .character
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: { _ in
            // Do Nothing
        })
        
        alert.addAction(byCreatedAt)
        alert.addAction(byCharacter)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
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
    func filterChanged(filter to: BucketState) {
        if currentFilter != to {
            currentFilter = to
            viewModel?.filterChanged(filter: to)
        }
    }
}
