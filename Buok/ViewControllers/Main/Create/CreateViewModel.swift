//
//  CreateViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon

public class CreateViewModel {
    public var bucketStatus: Dynamic<BucketStatus> = Dynamic(.none)
    public var tagList: Dynamic<[String]> = Dynamic([String]())
    
    public init() {
        bucketStatus = Dynamic(.none)
        tagList = Dynamic([String]())
    }
    
    public func setBucketStatus(status: BucketStatus) {
        self.bucketStatus = Dynamic(status)
    }
}
