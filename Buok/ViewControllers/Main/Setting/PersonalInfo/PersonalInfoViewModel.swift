//
//  PersonalInfoViewModel.swift
//  Buok
//
//  Created by denny on 2021/06/30.
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon

final class PersonalInfoViewModel {
    var personalInfoData: Dynamic<String> = Dynamic("")
    
    func getPersonalInfoData() {
        self.personalInfoData.value = ServiceInfoData.loadContentIntoString(name: "PersonalInfo")
    }
}
