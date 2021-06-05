//
//  DetailViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroNetwork

final class DetailViewModel {
    public var bucketItem: Dynamic<BucketModel?> = Dynamic(nil)
    public var state: Dynamic<BucketState> = Dynamic(.now)
    public var isBookmark: Dynamic<Bool> = Dynamic(false)
    
    func setPinBucket() {
        
    }
    
    func getBucketDetailInfo() {
        
    }
    
    func addBucketToBookmark() {
        BucketListAPIRequest.addBucketToBookmark(state: isBookmark.value, bucketId: bucketItem.value?.id ?? 0, responseHandler: { [weak self] result in
            switch result {
            case .success(let isSuccess):
                DebugLog("Add Bookmark Success : \(isSuccess)")
                self?.isBookmark.value = !(self?.isBookmark.value ?? false)
            case .failure(let error):
                ErrorLog("ERROR : \(error.statusCode) / \(error.localizedDescription)")
            }
        })
    }
}
