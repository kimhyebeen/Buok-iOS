//
//  CreateViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class CreateViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let backButton: HeroImageButton = HeroImageButton()
    private let doneButton: HeroImageButton = HeroImageButton()
    
    private let filterContentView: UIView = UIView()
    private let statusButton: HeroButton = HeroButton()
    private let statusContainerView: UIView = UIView()
    private let statusTitleLabel: UILabel = UILabel()
    private let statusImageView: UIImageView = UIImageView()
    
    private let categoryContainerView: UIView = UIView()
    private let categoryButton: HeroButton = HeroButton()
    private let categoryTitleLabel: UILabel = UILabel()
    private let categoryImageView: UIImageView = UIImageView()
    
    private let titleField: UITextField = UITextField()
    private let divisionBar: UIView = UIView()
    
    private let finishDateContainerView: UIView = UIView()
    private let finishDateTitleLabel: UILabel = UILabel()
    private let finishDateSelectButton: HeroButton = HeroButton()
    
    private let detailTitleLabel: UILabel = UILabel()
    private let detailBackgroundView: UIView = UIView()
    private let detailTextView: UITextView = UITextView()
    private let detailLengthLabel: UILabel = UILabel()
    
    private var viewModel: CreateViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLayout()
        setupViewProperties()
        bindViewModel()
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        view.addSubview(filterContentView)
        view.addSubview(titleField)
        view.addSubview(divisionBar)
        view.addSubview(finishDateContainerView)
        view.addSubview(detailTitleLabel)
        view.addSubview(detailBackgroundView)
        
        setupNavigationView()
        setupTitleSectionView()
        
        // MARK: Title
        titleField.snp.makeConstraints { make in
            make.top.equalTo(filterContentView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        divisionBar.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
        }
        
        // MARK: Finish Date
        finishDateContainerView.addSubview(finishDateTitleLabel)
        finishDateContainerView.addSubview(finishDateSelectButton)
        
        finishDateContainerView.snp.makeConstraints { make in
            make.top.equalTo(divisionBar.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        finishDateTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        finishDateSelectButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        setupDetailSectionView()
    }
    
    private func setupNavigationView() {
        topContentView.addSubview(backButton)
        topContentView.addSubview(doneButton)
        
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(13)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        doneButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(48)
            make.height.equalTo(32)
        }
    }
    
    private func setupTitleSectionView() {
        filterContentView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(16)
        }
        
        filterContentView.addSubview(statusContainerView)
        filterContentView.addSubview(categoryContainerView)
        
        statusContainerView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        statusContainerView.addSubview(statusTitleLabel)
        statusContainerView.addSubview(statusImageView)
        statusContainerView.addSubview(statusButton)
        statusContainerView.bringSubviewToFront(statusButton)
        
        statusTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        statusImageView.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.equalTo(statusTitleLabel.snp.trailing).offset(2)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        statusButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(statusContainerView.snp.trailing).offset(16)
        }
        
        categoryContainerView.addSubview(categoryTitleLabel)
        categoryContainerView.addSubview(categoryImageView)
        categoryContainerView.addSubview(categoryButton)
        categoryContainerView.bringSubviewToFront(categoryButton)
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.equalTo(categoryTitleLabel.snp.trailing).offset(2)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDetailSectionView() {
        detailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(finishDateContainerView.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(16)
        }
        
        detailBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(detailTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(200)
        }
        
        detailBackgroundView.addSubview(detailTextView)
        detailBackgroundView.addSubview(detailLengthLabel)
        
        detailTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        detailLengthLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.bucketStatus.bind({ status in
                DebugLog("BucketStatus Changed : \(status)")
            })
        }
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroGrayF2EDE8
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
        
        doneButton.layer.cornerRadius = 8
        doneButton.backgroundColor = .heroGray5B
        doneButton.titleLabel?.font = .font15P
        doneButton.setTitleColor(.heroWhite100s, for: .normal)
        doneButton.setTitle("Hero_Add_Item_Submit".localized, for: .normal)
        doneButton.addTarget(self, action: #selector(onClickDoneButton(_:)), for: .touchUpInside)
        
        statusTitleLabel.text = "Hero_Common_Status".localized
        statusTitleLabel.font = .font15P
        statusTitleLabel.textColor = .heroGray82
        statusButton.addTarget(self, action: #selector(onClickStatusFilterButton(_:)), for: .touchUpInside)
        statusImageView.image = UIImage(heroSharedNamed: "ic_narrow_12")
        
        categoryTitleLabel.text = "Hero_Common_Category".localized
        categoryTitleLabel.font = .font15P
        categoryTitleLabel.textColor = .heroGray82
        categoryButton.addTarget(self, action: #selector(onClickCategoryFilterButton(_:)), for: .touchUpInside)
        categoryImageView.image = UIImage(heroSharedNamed: "ic_narrow_12")
        
        titleField.font = .font20P
        titleField.textColor = .heroGrayA6A4A1
        titleField.placeholder = "Hero_Add_Title_Placeholder".localized
        divisionBar.backgroundColor = .heroGrayE7E1DC
        
        finishDateTitleLabel.text = "Hero_Add_FinishDate_Title".localized
        finishDateTitleLabel.font = .font15P
        finishDateTitleLabel.textColor = .heroGray82
        
        finishDateSelectButton.setTitle("Hero_Add_FinishDate_Description".localized, for: .normal)
        finishDateSelectButton.setTitleColor(.heroGrayA6A4A1, for: .normal)
        finishDateSelectButton.titleLabel?.font = .font15P
        finishDateSelectButton.addTarget(self, action: #selector(onClickFinishDateButton(_:)), for: .touchUpInside)
        
        detailTitleLabel.text = "상세 내용"
        detailTitleLabel.font = .font15P
        detailTitleLabel.textColor = .heroGray82
        
        detailBackgroundView.backgroundColor = .heroWhite100s
        detailBackgroundView.layer.cornerRadius = 7
        
        detailTextView.delegate = self
        detailTextView.font = .font13P
        detailTextView.textColor = .heroGrayDA
        detailTextView.text = "메모할 내용을 기입해보세요.\n혹은 버킷리스트와 관련해서 상세 내용을 입력해봅시다!"
        
        detailLengthLabel.font = .font13P
        detailLengthLabel.textColor = .heroGrayA6A4A1
        detailLengthLabel.text = "0/1500"
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func onClickDoneButton(_ sender: Any?) {
        DebugLog("Done Button Clicked")
    }
    
    @objc
    private func onClickStatusFilterButton(_ sender: Any?) {
        DebugLog("StatusFilter Clicked")
    }
    
    @objc
    private func onClickCategoryFilterButton(_ sender: Any?) {
        DebugLog("CategoryFilter Clicked")
    }
    
    @objc
    private func onClickFinishDateButton(_ sender: Any?) {
        DebugLog("FinishDateButton Clicked")
    }
}

extension CreateViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .heroGrayDA {
            textView.text = nil
            textView.textColor = .heroGray5B
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모할 내용을 기입해보세요.\n혹은 버킷리스트와 관련해서 상세 내용을 입력해봅시다!"
            textView.textColor = .heroGrayDA
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == .heroGrayDA {
            detailLengthLabel.text = "0/1500"
        } else {
            detailLengthLabel.text = "\(textView.text.count)/1500"
        }
    }
}
