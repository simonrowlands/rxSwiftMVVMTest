//
//  DetailTableViewController.swift
//  NCUTestProject
//
//  Created by Simon Rowlands on 11/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import UIKit

import RxSwift
import RxDataSources

class DetailTableViewController: UITableViewController {
    
    var disposeBag = DisposeBag() // Should this be here?
    
    var viewModel: InformationTableViewModel? {
        didSet {
            setupTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        
        setupTableView()
    }
    
    func setupTableView() {
        
        guard isViewLoaded, let viewModel = viewModel else {
            return
        }
        
        tableView.dataSource = nil // Required as dataSource is being replaced
        
        Observable.of(viewModel.informationSet).bind(to: tableView.rx.items(cellIdentifier: "detailViewCell", cellType: DetailTableViewCell.self)) { row, information, cell in
            
            cell.titleLabel.text = "Row: \(row). \(information.title)"
            cell.detailLabel.text = information.details
            
        }.disposed(by: disposeBag)
    }
    
    @IBAction func generateButtonTapped() {
        
        /*
         Feels hacky; a workaround for static data binding. Better way?
         Doesn't seem to have any performance hit with 1000 rows but may do with more complicated data / images etc.
         */
        
        viewModel?.generateNewInformationSet()
        
        setupTableView()
    }
}
