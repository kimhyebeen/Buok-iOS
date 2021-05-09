//
//  ForgetViewModel.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/09.
//

import Foundation

class ForgetViewModel {
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func requestCheckingEmail(_ email: String) -> Bool {
        // 이메일 존재 여부 요청
        return true
    }
}
