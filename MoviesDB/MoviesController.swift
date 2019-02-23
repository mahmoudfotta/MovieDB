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
        title = "Movies DB"
        setupTableView()
        handleDataDownloaded()
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = dataSource
    }

    func handleDataDownloaded() {
        dataSource.dataChanged = { [weak self] success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    self.tableView.tableFooterView = nil
                    self.tableView.reloadData()
                } else {
                    self.tableView.tableFooterView = nil
                }
            }
        }
    }
}

extension MoviesController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        addLoadingIndicator(to: tableView, indexPath: indexPath)
    }

    fileprivate func addLoadingIndicator(to tableView: UITableView, indexPath: IndexPath) {
        if dataSource.isLastCell(in: tableView, indexPath: indexPath) {
            tableView.tableFooterView = IndicatorView()
            tableView.tableFooterView?.isHidden = false
        }
    }
}
