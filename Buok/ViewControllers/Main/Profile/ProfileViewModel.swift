//
//  FriendPageViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroCommon
import HeroUI
import Promise

class ProfileViewModel {
    var userId: Int = 0
    var isMe: Dynamic<Bool> = Dynamic(false)
	var isFriendStatus: Dynamic<FriendButtonType> = Dynamic(.none)
    
	var bucketBookData: Dynamic<[ProfileBucketModel]> = Dynamic([ProfileBucketModel]())
    var bucketBookCount: Dynamic<Int> = Dynamic(0)
    
    var bookmarkData: Dynamic<[BookmarkListData]> = Dynamic([BookmarkListData]())
    var bookmarkCount: Dynamic<Int> = Dynamic(0)
    
    var myUserData: Dynamic<MyPageUserData?> = Dynamic(nil)
    var userData: Dynamic<ProfileUserData?> = Dynamic(nil)
    
    func fetchProfileUserInfo() {
        UserAPIRequest.getUserPageInfo(userId: userId, responseHandler: { result in
            switch result {
            case .success(let userData):
                DebugLog(userData.debugDescription())
                self.userData.value = userData
                self.bucketBookCount.value = userData.bucketCount
                self.bucketBookData.value = userData.bucket ?? []
				self.bookmarkCount.value = userData.bookmark?.bookMarkCount ?? 0
				self.bookmarkData.value = userData.bookmark?.bookmarkList ?? [BookmarkListData]()
				
				switch userData.isFriend {
				case 1:
					self.isFriendStatus.value = .friend
				case 2:
					self.isFriendStatus.value = .request
				default:
					self.isFriendStatus.value = .none
				}
            case.failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
            }
        })
    }
    
    func fetchMyPageInfo() {
        UserAPIRequest.getMyPageIngo(responseHandler: { result in
            switch result {
            case .success(let myPageUserData):
                DebugLog(myPageUserData.debugDescription())
                self.myUserData.value = myPageUserData
                self.bookmarkCount.value = myPageUserData.bookmark.bookMarkCount
                self.bookmarkData.value = myPageUserData.bookmark.bookmarkList ?? [BookmarkListData]()
				self.userId = myPageUserData.user.id
            case .failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
            }
        })
    }
	
	func requestFriend(friendId: Int) {
		FriendAPIRequest.requestFriend(friendId: friendId, responseHandler: { result in
			switch result {
			case .success(let isSuccess):
				DebugLog("Accept Friend's Request Success : \(isSuccess)")
				self.isFriendStatus.value = .request
			case .failure(let error):
				ErrorLog("ERROR: \(error.statusCode) / \(error.localizedDescription)")
			}
		})
	}
	
	func deleteFriend(friendId: Int) {
		FriendAPIRequest.deleteFriend(friendId: friendId, responseHandler: { result in
			switch result {
			case .success(let isSuccess):
				DebugLog("Accept Friend's Request Success : \(isSuccess)")
				self.isFriendStatus.value = .request
			case .failure(let error):
				ErrorLog("ERROR: \(error.statusCode) / \(error.localizedDescription)")
			}
		})
	}
    
    func setRootVCToHomeVC() {
        let navigationVC = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navigationVC.viewControllers = [MainTabBarViewController()]
        navigationVC.isNavigationBarHidden = true
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navigationVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
