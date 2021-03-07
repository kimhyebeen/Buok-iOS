//
//  HeroTabBarItem.swift
//  HeroUI
//
//  Created by denny on 2021/03/07.
//

import Foundation

public struct HeroTabBarItem {
    public let title: String?
    public let image: UIImage?
    public var isEmphasis: Bool = false
    
    public init(title: String?, image: UIImage?, isEmphasis: Bool) {
        self.title = title
        self.image = image
        self.isEmphasis = isEmphasis
    }
}
