//
//  HomeViewModel.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon

public enum HomeFilter {
    case now
    case expect
    case done
    case all
}

public class HomeViewModel {
    var helloText = Dynamic("")
    
    public init() {
        
    }
    
    public func filterChanged(filter: HomeFilter) {
        // Setting the value of the Dynamic variable
        // will trigger the closure we defined in the View
        helloText.value = "\(filter)"
    }
}
