//
//  HomeViewModel.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon

public enum HomeFilter {
    case now
    case expect
    case done
    case all
}

public class HomeViewModel {
    var currentFilter: Dynamic<HomeFilter> = Dynamic(.now)
    var bucketCount: Dynamic<Int> = Dynamic(2)
    
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
