//
//  ApiManager.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

enum RequestError: Error, Equatable {
    case requestFailed(String)
}

enum EndPoint: CustomStringConvertible {
    case movies
    case image(path: String)

    var description: String {
        switch self {
        case .movies:
            return "\(baseURL)/3/discover/movie"
        case .image(let path):
            return "\(imageBaseURL)/t/p/w185/\(path)"
        }
    }
}

let baseURL = "https://api.themoviedb.org"
let imageBaseURL = "https://image.tmdb.org"

class ApiManager {
    var urlString: String
    var session: URLSession

    init(session: URLSession = .shared, endpoint: EndPoint) {
        self.urlString = "\(endpoint.description)"
        self.session = session
    }

    func getRequest(page: Int, onSuccess: @escaping (Data) -> Void, onError: ((RequestError) -> Void)? = nil) {
        guard var components = URLComponents(string: urlString) else {
            fatalError("Wrong url.")
        }
        components.queryItems = ["api_key": "acea91d2bff1c53e6604e4985b6989e2", "page": "\(page)"].map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let url = components.url else { return }
        startSession(with: url, onSuccess: onSuccess, onError: onError)
    }

    func getImage(onSuccess: @escaping (Data) -> Void, onError: ((RequestError) -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        startSession(with: url, onSuccess: onSuccess, onError: onError)
    }

    func startSession(with url: URL, onSuccess: @escaping (Data) -> Void, onError: ((RequestError) -> Void)? = nil) {
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
                onError?(RequestError.requestFailed(error?.localizedDescription ?? ""))
                return
            }
            DispatchQueue.main.async {
                onSuccess(data)
            }
        }.resume()
    }
}
