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
    
    private let disposeBag = DisposeBag()
    
    var viewModel: InformationTableViewModel? {
        didSet {
            setupTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        
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
        
        Observable.just(SectionOfInformation.generateSections())
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
