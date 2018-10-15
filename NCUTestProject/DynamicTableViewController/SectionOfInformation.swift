//
//  SectionOfInformation.swift
//  NCUTestProject
//
//  Created by Simon Rowlands on 12/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import Foundation

import RxDataSources

struct SectionOfInformation {
    var header: String
    var items: [Information]
    
    static func generateSections(size: Int = 5) -> [SectionOfInformation] {
        
        var sections = [SectionOfInformation]()
        
        for i in 1...5 {
            sections.append(SectionOfInformation(header: "Information \(i)", items: Information.createInformationSet(size: 5)))
        }
        
        return sections
    }
}

extension SectionOfInformation: SectionModelType {
    
    typealias Item = Information
    
    init(original: SectionOfInformation, items: [Item]) {
        self = original
        self.items = items
    }
}
