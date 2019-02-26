//
//  Movie.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

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
    var selectedImage: UIImage?
    
    init(title: String, overview: String, date: String, posterURL: String? = nil, selectedImage: UIImage? = nil) {
        self.title = title
        self.overview = overview
        self.date = date
        self.posterURL = posterURL
        self.selectedImage = selectedImage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        date = try container.decode(String.self, forKey: .date)
        posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
    }
}
