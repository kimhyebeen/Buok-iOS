//
//  EditProfileViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/04.
//

import HeroCommon
import Promise

class EditProfileViewModel {
    var nickname: Dynamic<String> = Dynamic("")
    var introduce: Dynamic<String> = Dynamic("")
    
    var profileImage: Dynamic<UIImage?> = Dynamic(nil)
    
    func requestSaveProfile() {
        
    }
    
    func fetchUserInfo() {
        UserAPIRequest.getMyPageIngo(responseHandler: { result in
            switch result {
            case .success(let myPageUserData):
                DebugLog(myPageUserData.debugDescription())
                self.nickname.value = myPageUserData.user.nickname
                self.introduce.value = myPageUserData.user.intro
                self.generateImageFromUrl(string: myPageUserData.user.profileUrl)
            case .failure(let error):
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
            }
        })
    }
    
    private func generateImageFromUrl(string: String?) {
        
    }
}
