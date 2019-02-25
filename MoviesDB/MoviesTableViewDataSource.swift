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
    var totalPages = 0
    var movies = [Movie]()
    var dataChanged: ((_ isSuccess: Bool) -> Void)?
    let cellId = "Cell"
    var myMovies = [Movie]()

    init(isTesting: Bool = false) {
        super.init()
        if !isTesting {
            requestMovies(at: page)
        }
    }

    func requestMovies(at page: Int) {
        let moviesResponse = MoviesResponse()
        moviesResponse.fetch(page: page, onSuccess: { (response) in
            self.handleResponse(response: response)
        }) { (error) in
            self.dataChanged?(false)
        }
    }

    func handleResponse(response: MoviesResponse) {
        movies.append(contentsOf: response.movies)
        totalPages = response.totalPages
        page += 1
        dataChanged?(true)
    }

    func shouldRequestMoreMovies(at page: Int, totalPages: Int) -> Bool {
        if page < totalPages {
            return true
        }
        return false
    }

    func requestMoreMovies(at page: Int, totalPages: Int, tableView: UITableView, indexPath: IndexPath) {
        if shouldRequestMoreMovies(at: page, totalPages: totalPages) && tableView.isLast(indexPath) {
            requestMovies(at: page)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if !myMovies.isEmpty {
            return 2
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !myMovies.isEmpty && section == 0 {
            return myMovies.count
        }
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !myMovies.isEmpty && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            let movie = myMovies[indexPath.row]
            cell.textLabel?.text = movie.title
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title

        requestMoreMovies(at: page, totalPages: totalPages, tableView: tableView, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !myMovies.isEmpty && section == 0 {
            return "My Movies"
        }
        return "All Movies"
    }
}
