//
//  HeroSelectViewController.swift
//  HeroUI
//
//  Created by denny on 2021/05/22.
//

import Foundation
import UIKit

public struct HeroSelectItem {
    public var iconImage: UIImage?
    public let title: String
    
    public init(iconImage: UIImage, title: String) {
        self.iconImage = iconImage
        self.title = title
    }
    
    public init(title: String) {
        self.title = title
    }
}

public protocol HeroSelectViewDelegate: AnyObject {
    func selectViewCloseClicked(viewController: HeroSelectViewController)
    
    func selectViewItemSelected(viewController: HeroSelectViewController, selected index: Int)
}

public class HeroSelectViewCell: UITableViewCell {
    static let identifier: String = "HeroSelectViewCell"
    
    private let contentStackView: UIStackView = UIStackView()
    private let iconView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    public var icon: UIImage? {
        didSet {
            iconView.image = icon
            iconView.isHidden = (icon == nil)
        }
    }
    
    public var contentTitle: String? {
        didSet {
            titleLabel.text = contentTitle
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(iconView)
        contentStackView.addArrangedSubview(titleLabel)
        
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(28)
        }
        
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        contentStackView.spacing = 16
        contentStackView.axis = .horizontal
        
        titleLabel.font = .font16P
        titleLabel.textColor = .heroGray5B
    }
}

public class HeroSelectViewController: UIViewController {
    private let overLayWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    private let contentView: UIView = UIView()
    private let selectContentView: UIView = UIView()
    
    private let titleView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton()
    private let separator: UIView = UIView()
    
    private let itemTableView: UITableView = UITableView()
    
    public weak var delegate: HeroSelectViewDelegate?
    
    public var titleContent: String = "" {
        didSet {
            titleLabel.text = titleContent
        }
    }
    
    public var itemList: [HeroSelectItem] = [HeroSelectItem]() {
        didSet {
            itemTableView.reloadData()
            itemTableView.snp.updateConstraints { make in
                make.height.equalTo(itemList.count * 44)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        overLayWindow.backgroundColor = .clear
        overLayWindow.windowLevel = .normal + 25
        overLayWindow.makeKeyAndVisible()
        overLayWindow.isHidden = false
        
        overLayWindow.addSubview(contentView)
        contentView.addSubview(selectContentView)
        
        contentView.backgroundColor = .heroGray333333700
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectContentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        selectContentView.layer.cornerRadius = 8
        selectContentView.layer.masksToBounds = true
        selectContentView.backgroundColor = .heroWhite100s
        
        selectContentView.addSubview(titleView)
        selectContentView.addSubview(itemTableView)
        titleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        itemTableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(itemList.count * 44)
            make.bottom.equalToSuperview()
        }
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(closeButton)
        titleView.addSubview(separator)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1.5)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(closeButton.snp.height)
        }
        
        titleLabel.font = .font17PMedium
        titleLabel.textColor = .heroGray5B
        closeButton.setImage(UIImage(heroSharedNamed: "ic_x_bold"), for: .normal)
        closeButton.addTarget(self, action: #selector(onClickClose(_:)), for: .touchUpInside)
        separator.backgroundColor = .heroGrayF1F1F1
        
        itemTableView.isScrollEnabled = false
        itemTableView.dataSource = self
        itemTableView.delegate = self
        itemTableView.backgroundColor = .clear
        itemTableView.alwaysBounceVertical = false
        itemTableView.separatorStyle = .none
        itemTableView.separatorInset = .zero
        itemTableView.register(HeroSelectViewCell.self, forCellReuseIdentifier: HeroSelectViewCell.identifier)
    }
    
    @objc
    private func onClickClose(_ sender: UIButton) {
        delegate?.selectViewCloseClicked(viewController: self)
    }
}

extension HeroSelectViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HeroSelectViewCell()
        cell.contentTitle = itemList[indexPath.row].title
        cell.icon = itemList[indexPath.row].iconImage
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectViewItemSelected(viewController: self, selected: indexPath.row)
    }
}
