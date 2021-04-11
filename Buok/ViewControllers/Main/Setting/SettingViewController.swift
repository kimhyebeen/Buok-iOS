//
//  SettingViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

enum SettingCellType: Int {
    case normal = 0
    case info
    case button
}

enum SettingType: Int {
    case mail = 0
    case connectedAccount
    case appVersion
    case lock
    case language
    case notification
    case dataManagement
    case backup
    case contact
    
    func getTitle() -> String {
        switch self {
        case .mail:
            return "메일 주소"
        case .connectedAccount:
            return "연결된 계정"
        case .appVersion:
            return "앱 버전"
        case .lock:
            return "잠금"
        case .language:
            return "언어"
        case .notification:
            return "알림"
        case .dataManagement:
            return "저장 데이터 관리"
        case .backup:
            return "백업"
        case .contact:
            return "연락처"
        }
    }
}

final class SettingViewController: HeroBaseViewController {
    private let tableView: UITableView = UITableView()
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        tableView.register(SettingInfoCell.self, forCellReuseIdentifier: SettingInfoCell.identifier)
        view.backgroundColor = .heroGraySample100s
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.heroGray600s]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "설정"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell {
            cell.selectionStyle = .none
            cell.type = getSettingType(by: indexPath)
            cell.cellType = getSettingCellType(by: indexPath)
            cell.backgroundColor = .heroGraySample100s
            return cell
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
