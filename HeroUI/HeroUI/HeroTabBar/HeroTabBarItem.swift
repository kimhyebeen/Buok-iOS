//
//  HeroTabBarItem.swift
//  HeroUI
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

public struct HeroTabBarItem {
    public let title: String?
    public let image: UIImage?
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
