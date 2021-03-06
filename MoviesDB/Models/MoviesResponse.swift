//
//  MoviesResponse.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }

    var page: Int
    var totalPages: Int
    var totalResults: Int
    var movies: [Movie]

    init() {
        page = 0
        totalPages = 0
        totalResults = 0
        movies = [Movie]()
    }
    
    init(page: Int, totalPages: Int, totalResults: Int, movies: [Movie]) {
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.movies = movies
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
    
    func fetch(using session: URLSession = .shared, page: Int, onSuccess: @escaping (MoviesResponse) -> Void, onError: ((RequestError) -> Void)? = nil) {
        let apiManager = ApiManager(session: session, endpoint: .movies)
        apiManager.getRequest(page: page, onSuccess: { (data) in
            let decodedData = self.decodeResponse(from: data)
            onSuccess(decodedData)
        }) { (error) in
            onError?(error)
        }
    }

    func shouldRequestMoreMovies(at page: Int, totalPages: Int, moviesCount: Int, totalResult: Int) -> Bool {
        if page < totalPages && moviesCount < totalResult {
            return true
        }
        return false
    }

    private func decodeResponse(from data: Data) -> MoviesResponse {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(MoviesResponse.self, from: data)
            return decodedData
        } catch {
            print(error)
            assert(false)
        }
    }
}
