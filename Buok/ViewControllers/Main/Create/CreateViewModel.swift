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
    
    public var isPostSuccess: Dynamic<Bool>
    
    public let statusItemList: [HeroSelectItem] = [HeroSelectItem(title: "예정"),
                                                   HeroSelectItem(title: "진행"),
                                                   HeroSelectItem(title: "완료")]
    
    public let categoryItemList: [HeroSelectItem] = [HeroSelectItem(title: "여행"),
                                                     HeroSelectItem(title: "취미"),
                                                     HeroSelectItem(title: "소유"),
                                                     HeroSelectItem(title: "재정"),
                                                     HeroSelectItem(title: "건강"),
                                                     HeroSelectItem(title: "목표"),
                                                     HeroSelectItem(title: "조직"),
                                                     HeroSelectItem(title: "봉사"),
                                                     HeroSelectItem(title: "기타")]
    
    public init() {
        bucketStatus = Dynamic(.pre)
        bucketCategory = Dynamic(.travel)
        bucketTitle = Dynamic("")
        bucketContent = Dynamic("")
        finishDate = Dynamic(Date())
        imageList = Dynamic([UIImage]())
        imageURLStringList = Dynamic([String]())
        tagList = Dynamic([String]())
        isPostSuccess = Dynamic(false)
    }
    
    public func setBucketFinishDate(date: Date) {
        self.finishDate.value = date
    }
    
    public func setBucketStatus(status: BucketStatus) {
        self.bucketStatus.value = status
    }
    
    public func uploadImageList() {
        // Image Upload 후 Post
        ImageUploadAPIRequest.imageUploadRequest(images: imageList.value, responseHandler: { result in
            switch result {
            case .success(let urlStrList):
                self.requestCreatePost(urlList: urlStrList)
            case .failure(let error):
                ErrorLog("Error : \(error.localizedDescription) / \(error.statusCode)")
            }
        })
    }
    
    public func requestCreatePost(urlList: [String]?) {
        let bucket = Bucket(bucketName: bucketTitle.value,
                            categoryId: bucketCategory.value.getCategoryIndex(),
                            content: bucketContent.value,
                            endDate: finishDate.value.convertToSmallString(),
                            imageList: urlList,
                            startDate: Date().convertToSmallString(),
                            bucketState: bucketStatus.value.rawValue + 2,
                            tagList: tagList.value)
        
        BucketListAPIRequest.bucketPostRequest(bucket: bucket, responseHandler: { result in
            switch result {
            case .success(let isSuccess):
                DebugLog("Post Request isSuccess : \(isSuccess)")
                self.isPostSuccess.value = true
            case .failure(let error):
                ErrorLog("Error : \(error.localizedDescription) / \(error.statusCode)")
                self.isPostSuccess.value = false
            }
        })
    }
}
