//
//  Dynamic.swift
//  HeroCommon
//
//  Created by Taein Kim on 2021/03/23.
//

import Foundation

public class Dynamic<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    public func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ val: T) {
        value = val
    }
}
