//
//  CreateViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon

public class CreateViewModel {
    public var bucketStatus: Dynamic<BucketStatus> = Dynamic(.pre)
    public var bucketTitle: Dynamic<String> = Dynamic("")
    public var finishDate: Dynamic<Date> = Dynamic(Date())
    public var tagList: Dynamic<[String]> = Dynamic([String]())
    
    public init() {
        bucketStatus = Dynamic(.pre)
        finishDate = Dynamic(Date())
        tagList = Dynamic([String]())
    }
    
    public func setBucketFinishDate(date: Date) {
        self.finishDate.value = date
    }
    
    public func setBucketStatus(status: BucketStatus) {
        self.bucketStatus.value = status
    }
}
