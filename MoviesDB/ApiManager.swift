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
    case decodeFailed
}

class ApiManager<T: Decodable> {
    var urlString: String
    var session: URLSession

    init(session: URLSession = .shared, urlString: String) {
        self.urlString = urlString
        self.session = session
    }

    func getRequest(page: Int, onSuccess: @escaping (T) -> Void, onError: ((RequestError) -> Void)? = nil) {
        guard var components = URLComponents(string: urlString) else {
            fatalError("Wrong url.")
        }

        components.queryItems = ["api_key": "acea91d2bff1c53e6604e4985b6989e2", "page": "\(page)"].map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else { return }

        session.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
                    onError?(RequestError.requestFailed(error?.localizedDescription ?? ""))
                    return
                }
                onSuccess(try self.decode(data))
            } catch {
                onError?(RequestError.decodeFailed)
            }
        }.resume()
    }

    func decode(_ data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw(RequestError.decodeFailed)
        }
    }
}
