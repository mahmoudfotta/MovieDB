//
//  AddMovieControllerDelegateHandler.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

class AddMovieControllerDelegateHandler: NSObject, AddMovieDelegate {
    var addMovieAction: ((Movie) -> Void)?
    
    func add(_ movie: Movie) {
        addMovieAction?(movie)
    }
}
