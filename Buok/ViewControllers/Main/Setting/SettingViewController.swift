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
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .heroGraySample100s
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.heroGray600s]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "설정"
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
