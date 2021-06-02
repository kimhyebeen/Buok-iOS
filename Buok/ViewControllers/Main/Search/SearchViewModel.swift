//
//  SearchViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/01.
//

import Foundation
import HeroCommon

final class SearchViewModel {
    var currentSearchType: Dynamic<SearchType> = Dynamic(.myBucket)
    var searchKeyword: Dynamic<String> = Dynamic("")
    
    func fetchSearchResult(type: SearchType, keyword: String) {
        switch type {
        case .myBucket:
            SearchAPIRequest.searchMyBucketData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let bucketList):
                    DebugLog("BucketList Count : \(bucketList.count)")
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        case .user:
            SearchAPIRequest.searchUserData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let userList):
                    DebugLog("UserList Count : \(userList.count)")
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        case .mark:
            SearchAPIRequest.searchBookmarkData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let bookmarkList):
                    DebugLog("BookmarkList Count : \(bookmarkList.count)")
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        }
    }
}
