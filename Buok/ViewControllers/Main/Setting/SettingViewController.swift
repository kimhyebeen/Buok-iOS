//
//  SettingViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/04/10.
//

import Foundation
import HeroCommon
import HeroUI

enum SettingCellType {
    case normal
    case info
    case button
}

enum SettingType {
    case mail
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRowCount(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell {
            cell.selectionStyle = .none
            cell.type = getSettingType(by: indexPath)
            cell.backgroundColor = .heroGraySample100s
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func getRowCount(by section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 3
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    private func getSettingType(by indexPath: IndexPath) -> SettingType {
        return .mail
    }
}
