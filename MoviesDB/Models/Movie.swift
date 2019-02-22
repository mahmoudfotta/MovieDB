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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        date = try container.decode(String.self, forKey: .date)
        posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
    }

    static func fetch(using session: URLSession = .shared, page: Int, onSuccess: @escaping (MoviesResponse) -> Void, onError: ((RequestError) -> Void)? = nil) {
        let apiManager = ApiManager<MoviesResponse>(session: session, urlString: "https://api.themoviedb.org/3/discover/movie")
        apiManager.getRequest(page: page, onSuccess: { (response) in
            onSuccess(response)
        }) { (error) in
            onError?(error)
        }
    }
}
