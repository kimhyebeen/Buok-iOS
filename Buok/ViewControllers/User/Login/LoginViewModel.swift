//
//  LoginViewModel.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/07.
//

import Promise

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isSelectedEyeButton: Bool = false
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool { password.count >= 6 }
    
    func requestLogin() -> String? {
        // todo - email, password를 사용해서 로그인 요청
        print("email: \(email), password: \(password)")
        return nil
    }
}
