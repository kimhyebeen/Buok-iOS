//
//  HeroBaseViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/01.
//

import Foundation
import HeroCommon
import HeroUI
import SnapKit

public class HeroBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    public var isKeyboardShowing: Bool = false
    public var observers: [NSObjectProtocol] = []
    
    open var keyboardInsetsAdjustingScrollView: UIScrollView? {
        return nil
    }
    
    // Keyboard Observation
    open var registerKeyboardObservers: Bool {
        return false
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .heroServiceSkin
        
        if registerKeyboardObservers {
            registerKeyboardNotifications()
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    open func setupDefaultNavigationBarStyle() {
        edgesForExtendedLayout = [.bottom, .left, .right]
        navigationController?.navigationBar.isTranslucent = false
        
        if let bar = navigationController?.navigationBar as? HeroUINavigationBar {
            bar.setDefaultShadowImage()
        }
    }
    
    open func pushViewController(_ viewController: UIViewController?, animated: Bool = true, bottomBarHidden: Bool = false) {
        if let viewController = viewController, let navigationController = navigationController {
            if bottomBarHidden {
                viewController.hidesBottomBarWhenPushed = bottomBarHidden
            }
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    open func registerKeyboardNotifications() {
        let observer = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.adjustForKeyboard(notification: notification)
        })
        observers.append(observer)
        
        let changeObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.adjustForKeyboard(notification: notification)
        })
        observers.append(changeObserver)
    }
    
    open func adjustForKeyboard(notification: Notification) {
        if !isKeyboardShowing {
            return
        }
        
        guard let scrollView = keyboardInsetsAdjustingScrollView else { return }
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        var inset = scrollView.contentInset
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            inset.bottom = 0
        } else {
            inset.bottom = keyboardViewEndFrame.height
            inset.bottom -= view.safeAreaInsets.bottom
        }
        scrollView.contentInset = inset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers = []
    }
}
