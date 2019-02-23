//
//  Movie.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case date = "release_date"
        case posterURL = "poster_path"
    }

    var title: String
    var overview: String
    var date: String
    var posterURL: String?

    init(title: String, overview: String, date: String, posterURL: String?) {
        self.title = title
        self.overview = overview
        self.date = date
        self.posterURL = posterURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        date = try container.decode(String.self, forKey: .date)
        posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
    }

    static func fetch(using session: URLSession = .shared, page: Int, onSuccess: @escaping (MoviesResponse) -> Void, onError: ((RequestError) -> Void)? = nil) {
        let apiManager = ApiManager(session: session, urlString: "https://api.themoviedb.org/3/discover/movie")
        apiManager.getRequest(page: page, onSuccess: { (data) in
            let decodedData = Movie.decodeMovies(from: data)
            onSuccess(decodedData)
        }) { (error) in
            onError?(error)
        }
    }
    
    private static func decodeMovies(from data: Data) -> MoviesResponse {
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
