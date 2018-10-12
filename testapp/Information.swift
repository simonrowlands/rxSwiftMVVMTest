//
//  Information.swift
//  testapp
//
//  Created by Simon Rowlands on 11/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import Foundation

import RxSwift
import RxDataSources

struct Information {
    
    var title: String
    var details: String
    
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
    
    static func createInformationSet(size: Int = 1000) -> [Information] {
        
        var informationSet = [Information]()
        
        for _ in 1...size {
            informationSet.append(Information(title: UUID().uuidString, details: UUID().uuidString))
        }
        
        return informationSet
    }
}
