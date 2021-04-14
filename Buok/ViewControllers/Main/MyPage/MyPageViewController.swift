//
//  MyPageViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/03/06.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class MyPageViewController: HeroBaseViewController {
    private var collectionView: UICollectionView!
    
    private let profileView: MyPageProfileView = MyPageProfileView()
    private let mediumForFixPosition: UIView = {
        $0.backgroundColor = .heroWhite100s
        return $0
    }(UIView())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        if let navBar = navigationController?.navigationBar as? HeroUINavigationBar {
            navBar.tintColor = .heroGray600s
            navBar.barTintColor = .heroGraySample100s
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setRightHeroBarButtonItem(
            UIBarButtonItem(image: UIImage(heroSharedNamed: "tab_home.png")?.withRenderingMode(.alwaysTemplate),
                            style: .plain,
                            target: self,
                            action: #selector(onClickSetting(_:))),
            animated: false)
        
//        let backButtonImage = UIImage(heroSharedNamed: "tab_home.png")
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        view.backgroundColor = .heroGraySample100s
        setupViewLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc
    private func onClickSetting(_ sender: Any) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    private func setupViewLayout() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        
        view.addSubview(collectionView)
        view.addSubview(profileView)
        view.addSubview(mediumForFixPosition)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        collectionView.backgroundColor = .heroGraySample100s
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        mediumForFixPosition.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset =
            UIEdgeInsets(top: 244 + 16,
                         left: 0, bottom: 0, right: 0)
    }
    
//    @objc
//    private func onClickSample(_ sender: UIButton) {
//        let alertController = HeroAlertController(rootViewController: self)
//        alertController.setPositiveAction(action: HeroAlertAction(content: "확인", handler: {
//            DebugLog("OK")
//            self.sampleButton.setTitle("Sample Button(OK)", for: .normal)
//        }))
//
//        alertController.setNegativeAction(action: HeroAlertAction(content: "취소", handler: {
//            DebugLog("Cancel")
//            self.sampleButton.setTitle("Sample Button(Cancel)", for: .normal)
//        }))
//
//        alertController.showAlert(title: "샘플 타이틀", message: "샘플 텍스트입니다. 샘플 텍스트입니다.", buttonSetType: .okCancel)
//    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let offsetHeaderStop: CGFloat = 191 + 16
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let totalOffset = scrollView.contentOffset.y + profileView.bounds.height
            + mediumForFixPosition.bounds.height
        
        var headerTransform = CATransform3DIdentity
        var segmentTransform = CATransform3DIdentity
        
//        if totalOffset < 0 {
//            let headerScaleFactor: CGFloat = -(totalOffset) / profileView.bounds.height
//            let headerSizevariation = ((profileView.bounds.height * (1.0 + headerScaleFactor)) - profileView.bounds.height) / 2
//            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
//            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
//        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-MyPageViewController.offsetHeaderStop, -totalOffset), 0)
//        }
        
        profileView.layer.transform = headerTransform
        
        let segmentViewOffset = -totalOffset
        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -MyPageViewController.offsetHeaderStop), 0)
        mediumForFixPosition.layer.transform = segmentTransform
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colors: [UIColor] = [.systemBlue, .systemGreen, .systemTeal, .systemYellow, .systemPink]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row % 5]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
