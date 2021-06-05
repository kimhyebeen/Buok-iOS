//
//  HomeViewModel.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

public enum BucketState: Int {
    case now = 3
    case expect = 2
    case done = 4
    case all = 1
    case failure = 5
    
    public func getTitle() -> String {
        switch self {
        case .now:
            return "Hero_Home_Filter_Now".localized
        case .expect:
            return "Hero_Home_Filter_Expect".localized
        case .done:
            return "Hero_Home_Filter_Done".localized
        case .all:
            return "Hero_Home_Filter_All".localized
        case .failure:
            return "실패"
        }
    }
}

public enum BucketSort: Int {
    case created = 1
    case character = 2
    
    public func getTitle() -> String {
        switch self {
        case .created:
            return "작성순"
        case .character:
            return "가나다순"
        }
    }
}

public class HomeViewModel {
    var currentFilter: Dynamic<BucketState> = Dynamic(.now)
    var bucketCount: Dynamic<Int> = Dynamic(0)
    var bucketCategory: Dynamic<BucketCategory> = Dynamic(.noCategory)
    
    var bucketList: Dynamic<[BucketModel]> = Dynamic([BucketModel]())
    var bucketSort: Dynamic<BucketSort> = Dynamic(.created) // 추후 구현
    
    public let categoryItemList: [HeroSelectItem] = [HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_travel")!, title: "여행"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_hobby")!, title: "취미"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_want")!, title: "소유"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_finance")!, title: "재정"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_health")!, title: "건강"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_goal")!, title: "목표"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_community")!, title: "조직"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_volunteer")!, title: "봉사"),
                                            HeroSelectItem(iconImage: UIImage(heroSharedNamed: "ic_category_etc")!, title: "기타")]
    
    public init() {
        
    }
    
    public func filterChanged(filter: BucketState) {
        currentFilter.value = filter
    }
    
    func refreshToken() {
        TokenAPIRequest.refreshTokenRequest(responseHandler: { result in
            switch result {
            case .success(let tokenData):
                DebugLog("갱신 된 토큰 정보\nAccessToken: \(tokenData.accessToken)\nRefreshToken: \(tokenData.accessToken)")
                DebugLog("AccessToken ExpiredAt : \(tokenData.accessToken)\nRefreshToken ExpiredAt : \(tokenData.accessToken)")
            case .failure(let error):
                DebugLog("refreshToken ERROR : \(error.localizedDescription)")
            }
        })
    }
    
    func fetchBucketList() {
        BucketListAPIRequest.getBucketListData(state: currentFilter.value.rawValue, category: bucketCategory.value.getCategoryIndex(), sort: bucketSort.value.rawValue, responseHandler: { result in
            switch result {
            case .success(let listData):
                DebugLog("Fetch Bucket List")
                DebugLog(listData.debugDescription())
                self.bucketCount.value = listData.bucketCount
                self.bucketList.value = listData.buckets
            case .failure(let error):
                DebugLog("fetchBookmarkList ERROR : \(error.localizedDescription)")
            }
        })
    }
}
