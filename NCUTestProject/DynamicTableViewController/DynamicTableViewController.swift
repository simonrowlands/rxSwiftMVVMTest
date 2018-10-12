//
//  DynamicTableViewController.swift
//  NCUTestProject
//
//  Created by Simon Rowlands on 11/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import UIKit

import RxSwift
import RxDataSources

class DynamicTableViewController: UITableViewController {
    
    var disposeBag = DisposeBag() // Should this go here?
    
    var viewModel: InformationTableViewModel? {
        didSet {
            setupUI()
        }
    }
    
    func setupUI() {
        
        tableView.dataSource = nil
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfInformation>(configureCell: { dataSource, tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicViewCell", for: indexPath) as! DetailTableViewCell
            
            cell.titleLabel.text = "Row: \(indexPath.row). \(item.title)"
            cell.detailLabel.text = item.details
            
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
            return true
        }
        
        dataSource.canMoveRowAtIndexPath = { dataSource, indexPath in
            return true
        }
        
        let sections = SectionOfInformation.generateSections()
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// Will extract all below from this file at some point

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
