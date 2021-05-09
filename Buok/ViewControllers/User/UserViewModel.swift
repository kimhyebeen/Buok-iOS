//
//  LoginViewModel.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/07.
//

import Promise

class UserViewModel {
    var email: String = ""
    var password: String = ""
    var nickname: String = ""
    var isSelectedEyeButton: Bool = false
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool { password.count >= 6 }
    
    func validateNickName(_ nickname: String) -> Bool {
        let regex = "(?!.*[~`!@#$%&*()-+=.^_?,/\\|]).{1,12}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return nicknameTest.evaluate(with: nickname)
    }
    
    func isExistEmail(_ email: String) -> Bool {
        self.email = email
        // todo - email이 존재하는 계정인지 아닌지 확인 요청
        return false
    }
    
    func isExistNickname(_ nickname: String) -> Bool {
        self.nickname = nickname
        // todo - nickname이 존재하는 별칭인지 아닌지 확인 요청
        return false
    }
    
    func requestLogin() -> String? {
        // todo - email, password를 사용해서 로그인 요청
        print("email: \(email), password: \(password)")
        return nil
    }
}
