//
//  DynamicTableViewModelFromInformation.swift
//  testapp
//
//  Created by Simon Rowlands on 11/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import Foundation

class DynamicTableViewModelFromInformation: NSObject, InformationTableViewModel {
    
    var informationSet: [Information]
    
    init(informationSet: [Information]) {
        self.informationSet = informationSet
    }
    
    func generateNewInformationSet() {
        informationSet = Information.createInformationSet()
    }
}
