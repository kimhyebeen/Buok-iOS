//
//  WorkThruPageViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/30.
//

import Foundation
import Pageboy
import UIKit
import SnapKit

final class WorkThruPageViewController: PageboyViewController {
    // MARK: View Controllers
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for index in 0 ..< 4 {
            viewControllers.append(makeChildViewController(at: index))
        }
        return viewControllers
    }()
    
    private func makeChildViewController(at index: Int) -> WorkThruPageContentViewController {
        return WorkThruPageContentViewController(pageIndex: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    func nextPage() {
        scrollToPage(.next, animated: true)
    }
    
    func prevPage() {
        scrollToPage(.previous, animated: true)
    }
}

extension WorkThruPageViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        let count = viewControllers.count
        return count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        guard viewControllers.isEmpty == false else {
            return nil
        }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}

extension WorkThruPageViewController: PageboyViewControllerDelegate {
    public func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      willScrollToPageAt index: PageboyViewController.PageIndex,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
    }
    
    public func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didCancelScrollToPageAt index: PageboyViewController.PageIndex,
                                      returnToPageAt previousIndex: PageboyViewController.PageIndex) {
    }
    
    public func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollTo position: CGPoint,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
    }
    
    public func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPageAt index: PageboyViewController.PageIndex,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        (parent as? WorkThruViewController)?.updateView(index: index)
    }
    
    public func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didReloadWith currentViewController: UIViewController,
                                      currentPageIndex: PageboyViewController.PageIndex) {
    }
}
