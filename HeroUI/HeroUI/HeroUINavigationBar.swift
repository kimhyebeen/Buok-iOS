//
//  HeroUINavigationBar.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import UIKit

public class HeroUINavigationBar: UINavigationBar {
    private let emptyShadowImage: UIImage = UIImage(color: UIColor.clear, size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))
    private var defaultShadowImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc
    public func setDefaultShadowImage() {
        guard shadowImage != defaultShadowImage else { return }
        shadowImage = defaultShadowImage
    }
    
    @objc
    public func removeDefaultShadowImage() {
        guard shadowImage != emptyShadowImage else { return }
        shadowImage = emptyShadowImage
    }
    
    func reloadShadowImages() {
        defaultShadowImage = UIImage(color: UIColor.black.withAlphaComponent(0.15),
                                     size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))
    }
}

public extension UINavigationItem {
    func setRightBarButtonItem7(_ item: UIBarButtonItem?, animated: Bool) {
        guard let item = item else {
            rightBarButtonItem = nil
            rightBarButtonItems = nil
            return
        }
        
        setRightBarButton(item, animated: animated)
    }
    
    func setRightBarButtonItems7(_ items: [UIBarButtonItem]?, animated: Bool) {
        guard let items = items else {
            rightBarButtonItem = nil
            rightBarButtonItems = nil
            return
        }
        
        let buttonItems: [UIBarButtonItem] = items
        setRightBarButtonItems(buttonItems, animated: animated)
    }
    
    func setRightBarButtonItems7(_ items: [UIBarButtonItem]?) {
        setRightBarButtonItems7(items, animated: false)
    }
    
    func setLeftBarButtonItem7(_ item: UIBarButtonItem?, animated: Bool) {
        guard let item = item else {
            setLeftBarButton(nil, animated: animated)
            setLeftBarButtonItems(nil, animated: animated)
            return
        }
        
        setLeftBarButton(item, animated: animated)
    }
    
    func setLeftBarButtonItems7(_ items: [UIBarButtonItem]?, animated: Bool) {
        guard let items = items else {
            leftBarButtonItem = nil
            leftBarButtonItems = nil
            return
        }
        
        let buttonItems: [UIBarButtonItem] = items
        setLeftBarButtonItems(buttonItems, animated: animated)
    }
    
    func setLeftBarButtonItem7(_ item: UIBarButtonItem?) {
        setLeftBarButtonItem7(item, animated: false)
    }
    
    var rightBarButtonItem7: UIBarButtonItem? {
        if rightBarButtonItems != nil && rightBarButtonItems!.count > 0 {
            return rightBarButtonItems?.last
        }
        if rightBarButtonItem != nil {
            return rightBarButtonItem
        }
        return nil
    }
    
    var rightBarButtonItems7: [UIBarButtonItem]? {
        if rightBarButtonItems != nil {
            return rightBarButtonItems
        }
        if rightBarButtonItem != nil {
            return [rightBarButtonItem!]
        }
        return nil
    }
    
    var leftBarButtonItem7: UIBarButtonItem? {
        if leftBarButtonItems != nil && leftBarButtonItems!.count > 0 {
            return leftBarButtonItems?.last
        }
        if leftBarButtonItem != nil {
            return leftBarButtonItem
        }
        return nil
    }
    
    var leftBarButtonItems7: [UIBarButtonItem]? {
        if leftBarButtonItems != nil {
            return leftBarButtonItems
        }
        if leftBarButtonItem != nil {
            return [leftBarButtonItem!]
        }
        return nil
    }
    
    func setRightBarButtonItemEnabled(_ enabled: Bool) {
        rightBarButtonItem7?.isEnabled = enabled
    }
    
    func setLeftBarButtonItemEnabled(_ enabled: Bool) {
        leftBarButtonItem7?.isEnabled = enabled
    }
}
