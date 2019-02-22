//
//  ViewController.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class MoviesController: UITableViewController {
    var dataSource = MoviesTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Movies"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = dataSource
        dataSource.dataChanged = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

