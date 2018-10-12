//
//  DetailTableViewController.swift
//  testapp
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
            setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        guard isViewLoaded else {
            return
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        
        updateTableViewData()
    }
    
    func updateTableViewData() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        tableView.dataSource = nil
        
        Observable.of(viewModel.informationSet).bind(to: tableView.rx.items(cellIdentifier: "detailViewCell", cellType: DetailTableViewCell.self)) { row, information, cell in
            
            cell.titleLabel.text = "Row: \(row). \(information.title)"
            cell.detailLabel.text = information.details
            
        }.disposed(by: disposeBag)
    }
    
    @IBAction func generateButtonTapped() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        /*
         Feels hacky; a workaround static data binding.
         Should use dynamic data binding (see other tableView) if that functionality is required.
         Doesn't seem to have any performance hit with 1000 rows but may do with more complicated data / images etc.
         */
        
        viewModel.generateNewInformationSet()
        
        updateTableViewData()
    }
}
