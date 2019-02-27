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
    var addMovieDelegate = AddMovieControllerDelegateHandler()
    let loadingController = LoadingController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies DB"
        setupTableView()
        handleDataDownloaded()

        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addBarButton
    }

    func setupTableView() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: movieCellId)
        tableView.dataSource = dataSource
    }

    func handleDataDownloaded() {
        add(loadingController, frame: view.frame)
        dataSource.dataChanged = { [weak self] success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    self.loadingController.remove()
                    self.tableView.tableFooterView = nil
                    self.tableView.reloadData()
                } else {
                    self.loadingController.remove()
                    self.tableView.tableFooterView = nil
                }
            }
        }
    }

    @objc func addTapped() {
        let addController = AddMovieController()
        addController.delegate = addMovieDelegate
        addMovieDelegate.addMovieAction = {[weak self] movie in
            guard let self = self else { return }
            self.dataSource.myMovies.append(movie)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(addController, animated: true)
    }
}
