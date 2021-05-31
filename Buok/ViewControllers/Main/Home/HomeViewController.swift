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
    
    private let bucketCountBubble: UIView = UIView()
    private let bubbleTriangleView: UIImageView = UIImageView()
    private let countDescLabel: UILabel = UILabel()
    
    private var currentFilter: HomeFilter = .now
    public var viewModel: HomeViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        bindViewModel()
        setupMainLayout()
        setupViewProperties()
		notiButton.addTarget(self, action: #selector(onClickNotification(_:)), for: .touchUpInside)
        
        viewModel?.filterChanged(filter: .now)
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
        
        messageContainerView.isHidden = (filter == .all)
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
            make.height.equalTo(44)
        }
        
        bucketFilterView.snp.makeConstraints { make in
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

extension HomeViewController: BucketFilterDelegate {
    func filterChanged(filter to: HomeFilter) {
        if currentFilter != to {
            currentFilter = to
            viewModel?.filterChanged(filter: to)
        }
    }
}
