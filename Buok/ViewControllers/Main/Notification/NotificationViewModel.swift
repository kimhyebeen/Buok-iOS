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
		AlarmAPIRequest.alarmListRequest(responseHandler: { result in
			switch result {
			case .success(let listData):
				DebugLog("Fetch Notification List")
				self.notificationCount.value = listData.count
				self.notificationList.value = listData
			case .failure(let error):
				ErrorLog("fetchNotificationList ERROR : \(error.localizedDescription)")
			}
		})
	}
}
