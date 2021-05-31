//
//  WorkThruViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/30.
//

import Foundation
import HeroUI
import SnapKit

public class AccessibleUIPageControl: UIPageControl {
    public override func accessibilityIncrement() {
        currentPage += 1
        sendActions(for: .valueChanged)
    }

    public override func accessibilityDecrement() {
        currentPage -= 1
        sendActions(for: .valueChanged)
    }
}

public class WorkThruViewController: UIViewController {
    private let startButton = UIButton()
    private let nextButton = UIButton()
    private let pageContentView = UIView()
    private let pageIndicator = AccessibleUIPageControl()
    private let pageViewController = WorkThruPageViewController()
    
    private var viewModel: WorkThruViewModel?
    
    init(viewModel: WorkThruViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addChild(pageViewController)
        setupLayout()
        setupViewProperty()
    }
    
    public func updateView(index: Int) {
        pageIndicator.currentPage = index
        if index != 3 {
            startButton.isHidden = true
            nextButton.isHidden = false
        } else {
            startButton.isHidden = false
            nextButton.isHidden = true
        }
    }
    
    @objc
    private func didChangePage() {
        if pageViewController.currentIndex ?? 0 < pageIndicator.currentPage {
            pageViewController.nextPage()
        } else if pageViewController.currentIndex ?? 0 > pageIndicator.currentPage {
            pageViewController.prevPage()
        }
    }
    
    private func setupLayout() {
        view.addSubview(pageContentView)
        view.addSubview(startButton)
        view.addSubview(nextButton)
        view.addSubview(pageIndicator)
        view.bringSubviewToFront(nextButton)
        pageContentView.addSubview(pageViewController.view)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.right.equalToSuperview().offset(-20)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        pageContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-235)
        }
    }
    
    private func setupViewProperty() {
        view.backgroundColor = .white
        
        pageIndicator.numberOfPages = 4
        pageIndicator.currentPage = 0
        pageIndicator.currentPageIndicatorTintColor = .heroServiceNavy
        pageIndicator.pageIndicatorTintColor = .heroPrimaryBlueLight
        pageIndicator.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        
        nextButton.backgroundColor = .clear
        nextButton.setTitle("건너뛰기", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        nextButton.setTitleColor(.heroGray82, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        startButton.backgroundColor = .heroServiceNavy
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        startButton.setTitleColor(.heroWhite100s, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTouched), for: .touchUpInside)
        
        startButton.isHidden = true
    }
    
    @objc
    private func nextButtonTouched() {
        viewModel?.goToLoginVC()
    }
    
    @objc
    private func startButtonTouched() {
        viewModel?.goToLoginVC()
    }
}
