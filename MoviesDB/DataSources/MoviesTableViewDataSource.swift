//
//  MoviesTableViewDataSource.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

let movieCellId = "Cell"
enum MovieTableSectionsTitles: String {
    case allMovies = "All Movies"
    case myMovies = "My Movies"
}

class MoviesTableViewDataSource: NSObject, UITableViewDataSource {
    var page = 1
    var totalPages = 0
    var totalResults = 0
    var movies = [Movie]()
    var dataChanged: ((_ isSuccess: Bool) -> Void)?
    var myMovies = [Movie]()
    let moviesResponse = MoviesResponse()
    
    init(isTesting: Bool = false) {
        super.init()
        if CommandLine.arguments.contains("enable-testing") {
            setupUITests()
            return
        }
        if !isTesting {
            requestMovies(at: page)
        }
    }

    func requestMovies(at page: Int) {
        moviesResponse.fetch(page: page, onSuccess: { (response) in
            self.handleResponse(response: response)
        }) { (error) in
            self.dataChanged?(false)
        }
    }

    func handleResponse(response: MoviesResponse) {
        movies.append(contentsOf: response.movies)
        totalPages = response.totalPages
        totalResults = response.totalResults
        page += 1
        dataChanged?(true)
    }

    func requestMoreMovies(at page: Int, totalPages: Int, moviesCount: Int, totalResults: Int, tableView: UITableView, indexPath: IndexPath) {
        if moviesResponse.shouldRequestMoreMovies(at: page, totalPages: totalPages, moviesCount: moviesCount, totalResult: totalResults) && tableView.isLast(indexPath) {
            tableView.addLoadingIndicator(at: indexPath)
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
        let cell = cellForRow(tableView, at: indexPath)
        return cell
    }
    
    func cellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> MovieTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCellId, for: indexPath) as? MovieTableViewCell else{
            fatalError("Couldn't deque cell.")
        }
        if !myMovies.isEmpty && indexPath.section == 0 {
            let movie = myMovies[indexPath.row]
            cell.updateMyMovieCell(with: movie)
            return cell
        }
        let movie = movies[indexPath.row]
        cell.updateMovieCell(with: movie)
        requestMoreMovies(at: page, totalPages: totalPages, moviesCount: movies.count, totalResults: totalResults, tableView: tableView, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !myMovies.isEmpty && section == 0 {
            return MovieTableSectionsTitles.myMovies.rawValue
        }
        return MovieTableSectionsTitles.allMovies.rawValue
    }
    
    func setupUITests() {
        let moviesResponse = MoviesResponse(page: 1, totalPages: 1, totalResults: 40, movies: [Movie(title: "title test", overview: "overview test", date: "5-9-1993")])
        handleResponse(response: moviesResponse)
    }
}
