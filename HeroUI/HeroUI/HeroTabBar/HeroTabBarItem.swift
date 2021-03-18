//
//  HeroTabBarItem.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
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
