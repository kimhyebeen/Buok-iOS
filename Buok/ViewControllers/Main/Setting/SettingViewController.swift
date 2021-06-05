//
//  SettingViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

final class SettingViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let backButton: HeroImageButton = HeroImageButton()
    private let tableView: UITableView = UITableView()
    private let safeAreaFillView: UIView = UIView()
    
    private enum SectionType: Int {
        case account = 0
        case appVersion = 1
        case security = 2
        case data = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.addSubview(topContentView)
        setupSafeAreaFillView()
        setupNavigationView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.backgroundColor = .heroGrayE7E1DC
        tableView.tableFooterView = UIView()
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        tableView.register(SettingInfoCell.self, forCellReuseIdentifier: SettingInfoCell.identifier)
        view.backgroundColor = .heroGrayE7E1DC
        
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.heroGray82]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        navigationController?.navigationBar.backgroundColor = .heroGrayF2EDE8
//        navigationItem.title = "설정"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupSafeAreaFillView() {
        view.addSubview(safeAreaFillView)
        safeAreaFillView.backgroundColor = .heroGrayF2EDE8
        safeAreaFillView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupNavigationView() {
        topContentView.addSubview(titleLabel)
        topContentView.addSubview(backButton)
        topContentView.backgroundColor = .heroGrayF2EDE8
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        titleLabel.font = .font17PBold
        
        titleLabel.textColor = .heroGray82
        titleLabel.text = "설정"
        
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SettingSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingType = getSettingType(by: indexPath)
        if let vc = SettingNavigator.getDestViewController(type: settingType) {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingType = getSettingType(by: indexPath)
        if settingType == .appVersion {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingInfoCell.identifier, for: indexPath) as? SettingInfoCell {
                cell.selectionStyle = .none
                cell.type = .appVersion
                cell.backgroundColor = .heroGrayF2EDE8
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell {
                cell.selectionStyle = .none
                cell.type = getSettingType(by: indexPath)
                cell.cellType = getSettingCellType(by: indexPath)
                cell.backgroundColor = .heroGrayF2EDE8
                
                if settingType == .mail {
                    cell.content = "test@gmail.com"
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    private func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case SectionType.account.rawValue:
            return 2
        case SectionType.appVersion.rawValue:
            return 1
        case SectionType.security.rawValue:
            return 3
        case SectionType.data.rawValue:
            return 3
        default:
            return 0
        }
    }
    
    private func getSettingType(by indexPath: IndexPath) -> SettingType {
        return SettingType(rawValue: getRowCount(indexPath)) ?? .mail
    }
    
    private func getSettingCellType(by indexPath: IndexPath) -> SettingCellType {
        if let type = SettingType(rawValue: getRowCount(indexPath)) {
            switch type {
            case .mail:
                return .normal
            case .appVersion:
                return .info
            default:
                return .button
            }
        }
        
        return .button
    }
    
    fileprivate func getRowCount(_ indexPath: IndexPath) -> Int {
        var rowCount = 0
        for section in 0..<indexPath.section {
            rowCount += numberOfRowsInSection(section)
        }
        rowCount += indexPath.row
        return rowCount
    }
}
