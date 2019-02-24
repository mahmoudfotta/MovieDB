//
//  AddMovieController.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/24/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class AddMovieController: UIViewController {
    let addView = AddMovieView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Movie"
    }

    override func loadView() {
        view = addView
    }
}

