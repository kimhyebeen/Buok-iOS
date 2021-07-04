//
//  SearchViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class SearchViewModel {
    var currentSearchType: Dynamic<SearchType> = Dynamic(.myBucket)
    var searchKeyword: Dynamic<String> = Dynamic("")
    
    var bucketSearchCount: Dynamic<Int> = Dynamic(0)
    var bucketSearchList: Dynamic<[SearchBucketModel]> = Dynamic([SearchBucketModel]())
	var bookmarkSearchCount: Dynamic<Int> = Dynamic(0)
	var bookmarkSearchList: Dynamic<[SearchBucketModel]> = Dynamic([SearchBucketModel]())
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
            SearchAPIRequest.searchBookmarkData(keyword: keyword, responseHandler: { result in
                switch result {
                case .success(let bookmarkList):
                    DebugLog("BookmarkList Count : \(bookmarkList.count)")
					self.bookmarkSearchCount.value = bookmarkList.count
					self.bookmarkSearchList.value = bookmarkList
                case .failure(let error):
                    ErrorLog("MyBucket Search Error : \(error.statusCode) / \(error.errorMessage)")
                }
            })
        }
    }
	
	func requestFriend(friendId: Int) {
		FriendAPIRequest.requestFriend(friendId: friendId, responseHandler: { result in
			switch result {
			case .success(let isSuccess):
				DebugLog("Accept Friend's Request Success : \(isSuccess)")
			case .failure(let error):
				ErrorLog("ERROR: \(error.statusCode) / \(error.localizedDescription)")
			}
		})
	}
	
	func deleteFriend(friendId: Int) {
		FriendAPIRequest.deleteFriend(friendId: friendId, responseHandler: { result in
			switch result {
			case .success(let isSuccess):
				DebugLog("Delete Friend's Request Success : \(isSuccess)")
			case .failure(let error):
				ErrorLog("ERROR: \(error.statusCode) / \(error.localizedDescription)")
			}
		})
	}
}

extension SearchViewModel {
    func gotoProfileDetail(userId: Int, navigation: UINavigationController?) {
        let vc = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewModel.userId = userId
        vc.viewModel = viewModel
        navigation?.pushViewController(vc, animated: true)
    }
    
    func gotoBucketDetail(indexPath: IndexPath, navigation: UINavigationController?) {
        let vc = DetailViewController()
        let viewModel = DetailViewModel()
        
        if currentSearchType.value == .mark {
            // bookmark
//            let bucket = bookmarkSearchList.value[indexPath.row]
//            let bucketItem = BucketModel(searchModel: bucket)
//            DebugLog("[TEST] bucket Item Id : \(bucketItem.id)")
//            DebugLog("[TEST] bucket Item Name : \(bucketItem.bucketName)")
//            viewModel.bucketItem.value = bucketItem
//            vc.viewModel = viewModel
//            vc.isMyDetailView = (bucket.userId == GlobalMyInfo.myUserId)
//            navigation?.pushViewController(vc, animated: true)
        } else if currentSearchType.value == .myBucket {
            // myBuok
            let bucket = bucketSearchList.value[indexPath.row]
            let bucketItem = BucketModel(searchModel: bucket)
            viewModel.bucketItem.value = bucketItem
            vc.viewModel = viewModel
            vc.isMyDetailView = true
            navigation?.pushViewController(vc, animated: true)
        }
    }
}
