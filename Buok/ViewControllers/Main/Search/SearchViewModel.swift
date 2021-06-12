//
//  SearchViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon

final class SearchViewModel {
    var currentSearchType: Dynamic<SearchType> = Dynamic(.myBucket)
    var searchKeyword: Dynamic<String> = Dynamic("")
    
    var bucketSearchCount: Dynamic<Int> = Dynamic(0)
    var bucketSearchList: Dynamic<[SearchBucketModel]> = Dynamic([SearchBucketModel]())
	var friendList: Dynamic<[SearchUserModel]> = Dynamic([SearchUserModel]())
	var isSearchedKeyword: Bool = false
    
    func fetchSearchResult(type: SearchType, keyword: String) {
        switch type {
        case .myBucket:
            SearchAPIRequest.searchMyBucketData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let bucketSearchList):
                    DebugLog("BucketList Count : \(bucketSearchList.count)")
                    self.bucketSearchCount.value = bucketSearchList.count
                    self.bucketSearchList.value = bucketSearchList
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        case .user:
            SearchAPIRequest.searchUserData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let userList):
                    DebugLog("UserList Count : \(userList.count)")
					self.friendList.value = userList
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        case .mark:
            SearchAPIRequest.searchMyBucketData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let bookmarkList):
                    DebugLog("BookmarkList Count : \(bookmarkList.count)")
					self.bucketSearchCount.value = bookmarkList.count
					self.bucketSearchList.value = bookmarkList
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        }
    }
}
