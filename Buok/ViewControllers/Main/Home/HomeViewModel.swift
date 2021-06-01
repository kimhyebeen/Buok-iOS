//
//  HomeViewModel.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroUI

public enum HomeFilter: Int {
    case now = 3
    case expect = 2
    case done = 4
    case all = 1
}

public enum HomeSort: Int {
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
    var currentFilter: Dynamic<HomeFilter> = Dynamic(.now)
    var bucketCount: Dynamic<Int> = Dynamic(2)
    var bucketCategory: Dynamic<BucketCategory> = Dynamic(.noCategory)
    
    var bucketSort: Dynamic<HomeSort> = Dynamic(.created) // 추후 구현
    
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
    
    public func filterChanged(filter: HomeFilter) {
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
    
    func fetchBookmarkList() {
        BucketListAPIRequest.getBucketListData(state: currentFilter.value.rawValue, category: bucketCategory.value.getCategoryIndex(), sort: bucketSort.value.rawValue, responseHandler: { result in
            switch result {
            case .success(let listData):
                DebugLog(listData.debugDescription())
                self.bucketCount.value = listData.bucketCount
            case .failure(let error):
                DebugLog("fetchBookmarkList ERROR : \(error.localizedDescription)")
            }
        })
    }
}
