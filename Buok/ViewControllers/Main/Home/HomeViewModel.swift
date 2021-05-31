//
//  HomeViewModel.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroUI

public enum HomeFilter {
    case now
    case expect
    case done
    case all
}

public class HomeViewModel {
    var currentFilter: Dynamic<HomeFilter> = Dynamic(.now)
    var bucketCount: Dynamic<Int> = Dynamic(2)
    var bucketCategory: Dynamic<BucketCategory> = Dynamic(.noCategory)
    
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
}
