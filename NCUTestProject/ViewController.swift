//
//  ViewController.swift
//  NCUTestProject
//
//  Created by Simon Rowlands on 09/10/2018.
//  Copyright © 2018 simontest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func detailButtonTapped() {
        
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailTableViewController") as? DetailTableViewController else {
            return
        }
        
        detailViewController.viewModel = DetailTableViewModelFromInformation(informationSet: Information.createInformationSet())
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func dynamicButtonTapped() {
        
        guard let dynamicViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DynamicTableViewController") as? DynamicTableViewController else {
            return
        }
        
        dynamicViewController.viewModel = DynamicTableViewModelFromInformation(informationSet: Information.createInformationSet())
        
        navigationController?.pushViewController(dynamicViewController, animated: true)
    }
}
