//
//  FriendPageViewModel.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroCommon
import HeroUI
import Promise

struct FriendProfile {
    var type: FriendButtonType = .friend
    
    var buokmarks: [BuokmarkFlag] = [
        BuokmarkFlag(date: "2021.03", title: "나홀로 북유럽\n배낭여행 떠나기", category: "ic_fill_travel"),
        BuokmarkFlag(date: "2021.01", title: "취뽀 성공하기", category: "ic_fill_goal"),
        BuokmarkFlag(date: "2020.12", title: "패러글라이딩 도전", category: "ic_fill_hobby"),
        BuokmarkFlag(date: "2020.11", title: "교양학점 A이상 받기", category: "ic_fill_goal"),
        BuokmarkFlag(date: "2020.09", title: "친구들과 일본여행가서\n초밥 먹기", category: "ic_fill_travel"),
        BuokmarkFlag(date: "2020.08", title: "버킷리스트6", category: "ic_fill_want"),
        BuokmarkFlag(date: "2020.06", title: "버킷리스트7", category: "ic_fill_volunteer"),
        BuokmarkFlag(date: "2020.02", title: "버킷리스트8", category: "ic_fill_finance"),
        BuokmarkFlag(date: "2019.08", title: "버킷리스트9", category: "ic_fill_health"),
        BuokmarkFlag(date: "2019.05", title: "버킷리스트10", category: "ic_fill_etc")]
    
    var bucketBooks: [String] = ["나홀로 북유럽 배낭여행 떠나기", "취뽀 성공하기", "패러글라이딩 도전",
                                 "교양학점 A이상 받기", "친구들과 일본여행가서 초밥 먹기", "버킷리스트",
                                 "버킷리스트", "버킷리스트", "버킷리스트", "버킷리스트", "버킷리스트",
                                 "버킷리스트", "버킷리스트", "버킷리스트", "버킷리스트", "버킷리스트", "버킷리스트"]
}

class FriendPageViewModel {
    private(set) var friendType: FriendButtonType = .friend
    private(set) var buokmarks: [BuokmarkFlag] = []
    private(set) var bucketBooks: [String] = []
    
    var bookmarkData: Dynamic<[BookmarkListData]> = Dynamic([BookmarkListData]())
    var bookmarkCount: Dynamic<Int> = Dynamic(0)
    
    func fetchFriendProfile() -> Promise<FriendProfile> {
        // todo - 친구 api로 수정
        let fetchedProfile = FriendProfile()
        self.friendType = fetchedProfile.type
        self.buokmarks = fetchedProfile.buokmarks
        self.bucketBooks = fetchedProfile.bucketBooks
        return Promise(value: FriendProfile())
    }
}
