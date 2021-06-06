//
//  NotificationViewModel.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon

public class NotificationViewModel {
	var notificationCount: Dynamic<Int> = Dynamic(0)
	var notificationList: Dynamic<[NotificationModel]> = Dynamic([NotificationModel]())
	
	public init() {
		
	}
	
	func fetchNotificationList() {
		self.notificationCount.value = 4
		self.notificationList.value = [NotificationModel(title: "얼마 남지 않았어요⏰", content: "3월이 다가왔습니다. 새로운 마음가짐으로 의미있는 버킷북 생성 어떠세요?", type: "normal"), NotificationModel(title: "그동안 잘 지내셨나요💬", content: "3월 버킷북 점검 기간입니다. 완료 예정인 버킷북 5개를 확인해보세요.", type: "normal"), NotificationModel(nickname: "닉네임", type: "friend"), NotificationModel(title: "어떤 한 달을 보내셨나요?", content: "3월이 끝나고 있습니다. 이번 달 당신이 달성한 버킷북을 북마크 해보세요:)", type: "normal")]
		AlarmAPIRequest.alarmListRequest(responseHandler: { result in
			switch result {
			case .success(let listData):
				DebugLog("Fetch Notification List")
//				self.notificationCount.value = listData.count
//				self.notificationList.value = listData
			case .failure(let error):
				ErrorLog("fetchNotificationList ERROR : \(error.localizedDescription)")
			}
		})
	}
}
