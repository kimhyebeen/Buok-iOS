//
//  CreateViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroUI

public class CreateViewModel {
    public var bucketStatus: Dynamic<BucketStatus>
    public var bucketCategory: Dynamic<BucketCategory>
    public var bucketTitle: Dynamic<String>
    public var bucketContent: Dynamic<String>
    
    public var finishDate: Dynamic<Date>
    public var imageList: Dynamic<[UIImage]>
    public var imageURLStringList: Dynamic<[String]>
    public var tagList: Dynamic<[String]>
    
    public init() {
        bucketStatus = Dynamic(.pre)
        bucketCategory = Dynamic(.travel)
        bucketTitle = Dynamic("")
        bucketContent = Dynamic("")
        finishDate = Dynamic(Date())
        imageList = Dynamic([UIImage]())
        imageURLStringList = Dynamic([String]())
        tagList = Dynamic([String]())
    }
    
    public func setBucketFinishDate(date: Date) {
        self.finishDate.value = date
    }
    
    public func setBucketStatus(status: BucketStatus) {
        self.bucketStatus.value = status
    }
}
