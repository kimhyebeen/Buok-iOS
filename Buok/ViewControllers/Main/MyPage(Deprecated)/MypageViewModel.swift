//
//  MypageViewModel.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroCommon
import Promise

class MypageViewModel {
//    var buokmarks: [BuokmarkFlag] = []
    
    var bookmarkData: Dynamic<[BookmarkListData]> = Dynamic([BookmarkListData]())
    var bookmarkCount: Dynamic<Int> = Dynamic(0)
    var userData: Dynamic<MyPageUserData?> = Dynamic(nil)
    
    func fetchFriends() {
        
    }
    
    func fetchBucket() {
        
    }
    
//    func fetchBuokmarks() -> Promise<[BuokmarkFlag]> {
//        return Promise(value: { () -> [BuokmarkFlag] in
//            // todo - 북마크 api 가져오기
//            let flags = [
//                BuokmarkFlag(date: "2021.03", title: "나홀로 북유럽\n배낭여행 떠나기", category: "ic_fill_travel"),
//                BuokmarkFlag(date: "2021.01", title: "취뽀 성공하기", category: "ic_fill_goal"),
//                BuokmarkFlag(date: "2020.12", title: "패러글라이딩 도전", category: "ic_fill_hobby"),
//                BuokmarkFlag(date: "2020.11", title: "교양학점 A이상 받기", category: "ic_fill_goal"),
//                BuokmarkFlag(date: "2020.09", title: "친구들과 일본여행가서\n초밥 먹기", category: "ic_fill_travel"),
//                BuokmarkFlag(date: "2020.08", title: "버킷리스트6", category: "ic_fill_want"),
//                BuokmarkFlag(date: "2020.06", title: "버킷리스트7", category: "ic_fill_volunteer"),
//                BuokmarkFlag(date: "2020.02", title: "버킷리스트8", category: "ic_fill_finance"),
//                BuokmarkFlag(date: "2019.08", title: "버킷리스트9", category: "ic_fill_health"),
//                BuokmarkFlag(date: "2019.05", title: "버킷리스트10", category: "ic_fill_etc")]
//
//            buokmarks = flags
//
//            return flags
//        }())
//    }
    
    func fetchUserInfo() {
        UserAPIRequest.getMyPageIngo(responseHandler: { result in
            switch result {
            case .success(let myPageUserData):
                DebugLog(myPageUserData.debugDescription())
                self.userData.value = myPageUserData
                self.bookmarkCount.value = myPageUserData.bookmark.bookMarkCount
                self.bookmarkData.value = myPageUserData.bookmark.bookmarkList ?? [BookmarkListData]()
            case .failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
            }
        })
    }
}
