//
//  HeroAlertController.swift
//  HeroUI
//
//  Created by denny on 2021/03/13.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

public enum AlertButtonSetType {
    case okCancel
    case yesNo
}

public class HeroAlertAction {
    public var content: String?
    public var handler: () -> Void?
    
    public init(content: String, handler: @escaping () -> Void) {
        self.content = content
        self.handler = handler
    }
}

public class HeroAlertController {
    private var rootViewController: UIViewController
    private var positiveAction: HeroAlertAction?
    private var negativeAction: HeroAlertAction?
    
    private let alertVC = HeroAlertViewController()
    
    private var positiveHandler: (() -> Void)?
    private var negativeHandler: (() -> Void)?
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        
        positiveHandler = {
//            self.alertVC.dismissAlertVC()
//            self.alertVC.dismiss(animated: false, completion: nil)
            self.positiveAction?.handler()
        }
        
        negativeHandler = {
//            self.alertVC.dismissAlertVC()
//            self.alertVC.dismiss(animated: false, completion: nil)
            self.negativeAction?.handler()
        }
        
        alertVC.view.backgroundColor = .clear
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.positiveHandler = positiveHandler
        alertVC.negativeHandler = negativeHandler
        
    }
    
    public func setPositiveAction(action: HeroAlertAction) {
        self.positiveAction = action
    }
    
    public func setNegativeAction(action: HeroAlertAction) {
        self.negativeAction = action
    }
    
    public func showAlert(title: String?, message: String?, buttonSetType: AlertButtonSetType) {
        if let sTitle = title {
            alertVC.setTitle(title: sTitle)
        }

        if let sMessage = message {
            alertVC.setDescription(description: sMessage)
        }
        
        rootViewController.present(alertVC, animated: false, completion: nil)
    }
}
