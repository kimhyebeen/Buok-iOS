//
//  ForgetViewModel.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/09.
//  Fully Modified by Taein Kim on 2021/06/02.
//

import Foundation
import HeroCommon

class ForgetViewModel {
    var isEmailExist: Dynamic<Bool> = Dynamic(false)
    var isValidCode: Dynamic<Bool> = Dynamic(false)
    var isResetSuccess: Dynamic<Bool> = Dynamic(false)
    var isSelectedEyeButton: Bool = false
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validateVerifyCode(_ code: String) {
        EmailAuthAPIRequest.validateAuthCode(code: code, responseHandler: { result in
            switch result {
            case .success(let token):
                _ = TokenManager.shared.deleteAllTokenData()
                _ = TokenManager.shared.setPasswordResetToken(token: token)
                self.isValidCode.value = true
            case .failure(_):
                self.isValidCode.value = false
            }
        })
    }
    
    func requestCheckingEmail(_ email: String) {
        // 이메일 존재 여부 요청
        InfoCheckAPIRequest.checkEmail(email: email, responseHandler: { [weak self] result in
            switch result {
            case .success(_):
                // 존재합니다.
                self?.isEmailExist.value = true
            case .failure(_):
                // 존재하지 않습니다.
                self?.isEmailExist.value = false
            }
        })
    }
    
    func requestVerifyCode(_ email: String) {
        // 인증번호 확인 요청
        EmailAuthAPIRequest.requestAuthCode(email: email, responseHandler: { result in
            switch result {
            case .success(_):
                DebugLog("Validation Code Sent.")
            case .failure(_):
                ErrorLog("Validation Code Send Error")
            }
        })
    }
    
    func resetPassword(newPassword: String) {
        UserAPIRequest.resetPassword(newPassword: newPassword, responseHandler: { result in
            switch result {
            case .success(_):
                DebugLog("Reset Password Success")
                self.isResetSuccess.value = true
            case .failure(_):
                ErrorLog("Reset Password Failure")
                self.isResetSuccess.value = false
            }
        })
    }
    
    func validatePassword(_ password: String) -> Bool { password.count >= 6 }
}
