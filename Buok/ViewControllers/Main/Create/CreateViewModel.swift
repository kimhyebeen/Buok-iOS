//
//  CreateViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

public enum CreateErrorType {
    case statusError
    case categoryError
    case titleEmpty
    case titleExceed
    case contentEmpty
    case contentExceed
    case imageError
    case noError
    
    func getErrorMessage() -> String {
        switch self {
        case .statusError:
            return "상태를 선택해주세요."
        case .categoryError:
            return "카테고리를 선택해주세요."
        case .titleEmpty:
            return "제목을 입력해주세요."
        case .titleExceed:
            return "제목은 24자까지 입력할 수 있습니다."
        case .contentEmpty:
            return "내용을 입력해주세요."
        case .contentExceed:
            return "내용은 1500자까지 입력할 수 있습니다."
        case .imageError:
            return "이미지는 1개 이상 선택해야 합니다."
        default:
            return ""
        }
    }
}

public class CreateViewModel {
    public var bucketStatus: Dynamic<BucketStatus?>
    public var bucketCategory: Dynamic<BucketCategory?>
    public var bucketTitle: Dynamic<String>
    public var bucketContent: Dynamic<String>
    
    public var finishDate: Dynamic<Date>
    public var imageList: Dynamic<[UIImage]>
    public var imageURLStringList: Dynamic<[String]>
    public var tagList: Dynamic<[String]>
    
    public var errorType: Dynamic<CreateErrorType> = Dynamic(.noError)
    
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
    
    public init() {
        bucketStatus = Dynamic(nil)
        bucketCategory = Dynamic(nil)
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
    
    public func checkValidation() {
        let isStatusValid = (bucketStatus.value != nil)
        let isCategoryValid = (bucketCategory.value != nil)
        let isTitleValid = !bucketTitle.value.isEmpty
        let isTitleLengthValid = bucketTitle.value.count < 25
        let isContentValid = !bucketContent.value.isEmpty
        let isContentLengthValid = bucketContent.value.count < 1501
        let isImageValid = imageList.value.count > 0
        let isValid = isStatusValid && isCategoryValid && isTitleValid &&
            isTitleLengthValid && isContentValid && isContentLengthValid && isImageValid
        
        if isValid {
            uploadImageList()
        } else {
            errorType.value = !isStatusValid ? .statusError :
                (!isCategoryValid ? .categoryError :
                    (!isTitleValid ? .titleEmpty :
                        (!isTitleLengthValid ? .titleExceed
                            : (!isContentValid ? .contentEmpty :
                                (!isContentLengthValid ? .contentExceed :
                                    (!isImageValid ? .imageError : .noError))))))
        }
        
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
        if let category = bucketCategory.value, let status = bucketStatus.value {
            let bucket = BucketRequestModel(bucketName: bucketTitle.value,
                                            categoryId: category.getCategoryIndex(),
                                            content: bucketContent.value,
                                            endDate: finishDate.value.convertToSmallString(),
                                            imageList: urlList,
                                            startDate: Date().convertToSmallString(),
                                            bucketState: status.rawValue + 2,
                                            tagList: tagList.value)
            
            DebugLog("Create Bucket End Date : \(finishDate.value.convertToString())")
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
}
