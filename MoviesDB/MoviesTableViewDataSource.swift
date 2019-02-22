//
//  MoviesTableViewDataSource.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class MoviesTableViewDataSource: NSObject, UITableViewDataSource {
    var page = 1
    var movies = [Movie]()
    var dataChanged: (() -> Void)?
    let cellId = "Cell"

    init(isTesting: Bool = false) {
        super.init()
        if !isTesting {
            getMovies(at: page)
        }
    }
    
    func getMovies(at page: Int) {
        Movie.fetch(page: page, onSuccess: { (response) in
            self.movies = response.movies
            self.dataChanged?()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
}

