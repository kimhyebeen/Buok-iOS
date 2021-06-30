//
//  EditBucketViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI
import Promise

public class EditBucketViewModel {
    public var bucketId: Dynamic<Int>
    public var bucketStatus: Dynamic<BucketStatus>
    public var bucketCategory: Dynamic<BucketCategory>
    public var bucketTitle: String
    public var bucketContent: String
    private var isFinned: Bool = false
    private var isBookmarked: Bool = false
    
    public var startDate: Dynamic<Date>
    public var finishDate: Dynamic<Date>
    public var imageList: Dynamic<[UIImage]>
    public var imageURLStringList: Dynamic<[String]>
    public var tagList: Dynamic<[String]>
    
    public var isPostSuccess: Dynamic<Bool>
    
    public let statusItemList: [HeroSelectItem] = [HeroSelectItem(title: "예정"),
                                                   HeroSelectItem(title: "진행"),
                                                   HeroSelectItem(title: "완료"),
                                                   HeroSelectItem(title: "실패")]
    
    public let categoryItemList: [HeroSelectItem] = [HeroSelectItem(title: "여행"),
                                                     HeroSelectItem(title: "취미"),
                                                     HeroSelectItem(title: "소유"),
                                                     HeroSelectItem(title: "재정"),
                                                     HeroSelectItem(title: "건강"),
                                                     HeroSelectItem(title: "목표"),
                                                     HeroSelectItem(title: "조직"),
                                                     HeroSelectItem(title: "봉사"),
                                                     HeroSelectItem(title: "기타")]
    
    public init(detailModel: BucketDetailModel) {
        isFinned = detailModel.bucket.fin
        isBookmarked = detailModel.bucket.bookmark
        bucketId = Dynamic(detailModel.bucket.id)
        bucketStatus = Dynamic(BucketStatus(rawValue: detailModel.bucket.bucketState - 2) ?? .pre)
		bucketCategory = Dynamic(BucketCategory(rawValue: detailModel.bucket.categoryId - 2) ?? .goal)
        bucketTitle = detailModel.bucket.bucketName
        bucketContent = detailModel.bucket.content ?? ""
        startDate = Dynamic(detailModel.bucket.createdDate.convertToDate())
        finishDate = Dynamic(detailModel.bucket.endDate.convertToDate())
        imageList = Dynamic([UIImage]())
        imageURLStringList = Dynamic((detailModel.images ?? [ImageURLModel]()).map { $0.imageUrl })
        tagList = Dynamic((detailModel.tags ?? [TagModel]()).map { $0.tagName })
        isPostSuccess = Dynamic(false)
    }
    
    public func setBucketFinishDate(date: Date) {
        self.finishDate.value = date
    }
    
    public func setBucketStatus(status: BucketStatus) {
        self.bucketStatus.value = status
    }
    
    public func uploadImageList() {
        if imageList.value.count > 0 {
            // Image Upload 후 Post
            ImageUploadAPIRequest.imageUploadRequest(images: imageList.value, responseHandler: { result in
                switch result {
                case .success(let urlStrList):
                    urlStrList.forEach {
                        self.imageURLStringList.value.append($0)
                    }
                    self.checkFinOrBookmark(urlList: urlStrList)
                case .failure(let error):
                    ErrorLog("Error : \(error.localizedDescription) / \(error.statusCode)")
                }
            })
        } else {
            self.checkFinOrBookmark(urlList: nil)
        }
    }
    
    private func checkFinOrBookmark(urlList: [String]?) {
        if (bucketStatus.value == .pre || bucketStatus.value == .present) && isBookmarked {
            requestRemoveBookmark(urlList: urlList)
        } else if (bucketStatus.value == .success || bucketStatus.value == .failure) && isFinned {
            requestRemoveFin(urlList: urlList)
        } else {
            requestEditPost(urlList: urlList)
        }
    }
    
    private func requestRemoveFin(urlList: [String]?) {
        BucketListAPIRequest.setBucketPin(isPinned: false, bucketId: self.bucketId.value, responseHandler: { [weak self] result in
            switch result {
            case .success(let isSuccess):
                self?.requestEditPost(urlList: urlList)
                DebugLog("Set Pin Success : \(isSuccess)")
            case .failure(let error):
                ErrorLog("ERROR : \(error.statusCode) / \(error.localizedDescription)")
            }
        })
    }
    
    private func requestRemoveBookmark(urlList: [String]?) {
        BucketListAPIRequest.setBucketBookmark(state: false, bucketId: self.bucketId.value) { [weak self] result in
            switch result {
            case .success(let isSuccess):
                self?.requestEditPost(urlList: urlList)
                DebugLog("Set Bookmark Success : \(isSuccess)")
            case .failure(let error):
                ErrorLog("ERROR : \(error.statusCode) / \(error.localizedDescription)")
            }
        }
    }
    
    private func requestEditPost(urlList: [String]?) {
        let bucket = BucketRequestModel(bucketName: bucketTitle,
                                        categoryId: bucketCategory.value.getCategoryIndex(),
                                        content: bucketContent,
                                        endDate: finishDate.value.convertToSmallString(),
                                        imageList: imageURLStringList.value,
                                        startDate: startDate.value.convertToSmallString(),
                                        bucketState: bucketStatus.value.rawValue + 2,
                                        tagList: tagList.value)
        
        DebugLog("Edit Bucket End Date : \(finishDate.value.convertToString())")
        BucketListAPIRequest.editBucketInfo(bucketId: bucketId.value, bucket: bucket, responseHandler: { result in
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
