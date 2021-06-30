//
//  ZoomableImageConstant.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation

@objc public enum ScaleMode: Int {
    case aspectFill
    case aspectFit
    case widthFill
    case heightFill
}

@objc public enum Offset: Int {
    case begining
    case center
}
