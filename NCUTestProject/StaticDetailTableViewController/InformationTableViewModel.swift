//
//  DetailTableViewViewModel.swift
//  NCUTestProject
//
//  Created by Simon Rowlands on 11/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import Foundation

protocol InformationTableViewModel {
    var informationSet: [Information] { get }
    func generateNewInformationSet()
}
