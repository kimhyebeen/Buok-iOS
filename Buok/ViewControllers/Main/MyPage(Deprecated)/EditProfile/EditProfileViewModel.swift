//
//  EditProfileViewModel.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/04.
//

import HeroCommon
import Kingfisher
import Promise

class EditProfileViewModel {
    var nickname: Dynamic<String> = Dynamic("")
    var introduce: Dynamic<String> = Dynamic("")
    
    var profileImage: Dynamic<UIImage?> = Dynamic(nil)
    var changeProfileSuccess: Dynamic<Bool> = Dynamic(false)
    var nicknameErrorMessage: Dynamic<String> = Dynamic("")
    
    func uploadProfileImage() {
        if let image = profileImage.value {
            ImageUploadAPIRequest.imageUploadRequest(images: [image], responseHandler: { [weak self] result in
                switch result {
                case .success(let urls):
                    let profileURL = urls.first
                    self?.requestSaveProfile(profileURL: profileURL)
                case .failure(let error):
                    ErrorLog("ERROR : \(error.localizedDescription), \(error.statusCode)")
                }
            })
        } else {
            ErrorLog("프로필 이미지가 선택되지 않았거나 값이 nil입니다.")
        }
    }
    
    func requestSaveProfile(profileURL: String?) {
        let profile = ProfileData(intro: introduce.value, nickname: nickname.value, profileUrl: profileURL)
        UserAPIRequest.changeProfileInfo(profile: profile, responseHandler: { [weak self] result in
            switch result {
            case .success(let isSuccess):
                self?.changeProfileSuccess.value = isSuccess
            case .failure(let error):
                ErrorLog("ERROR : \(error.statusCode) / \(error.localizedDescription)")
                self?.changeProfileSuccess.value = false
            }
        })
    }
    
    func fetchUserInfo() {
        UserAPIRequest.getMyPageIngo(responseHandler: { [weak self] result in
            switch result {
            case .success(let myPageUserData):
                DebugLog(myPageUserData.debugDescription())
                self?.nickname.value = myPageUserData.user.nickname
                self?.introduce.value = myPageUserData.user.intro
                self?.generateImageFromUrl(string: myPageUserData.user.profileUrl)
            case .failure(let error):
                if error.statusCode == 400 {
                    self?.nicknameErrorMessage.value = "중복된 별칭입니다."
                }
                ErrorLog("API Error : \(error.statusCode) / \(error.errorMessage) / \(error.localizedDescription)")
            }
        })
    }
    
    private func generateImageFromUrl(string: String?) {
        if let thumbnailUrl = URL(string: string ?? "") {
            KingfisherManager.shared.retrieveImage(with: thumbnailUrl, completionHandler: { [weak self] result in
                switch result {
                case .success(let imageResult):
                    self?.profileImage.value = imageResult.image
                case .failure(let error):
                    ErrorLog("Image Retrive Error : \(error.localizedDescription)")
                }
            })
        }
    }
}
