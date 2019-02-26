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
    weak var delegate: AddMovieDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Movie"
        
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveBarButton
    }

    override func loadView() {
        view = addView
    }
    
    @objc func saveTapped() {
        guard let title = addView.titleTextField.text, !title.isEmpty else { return }
        guard let date = addView.dateTextField.text, !date.isEmpty else { return }
        guard let overview = addView.overviewTextView.text, !overview.isEmpty else { return }
        addMovie(with: title, date: date, overview: overview)
        navigationController?.popViewController(animated: true)
    }
    
    func addMovie(with title: String, date: String, overview: String) {
        let movie = Movie(title: title, overview: overview, date: date, posterURL: nil)
        delegate?.add(movie)
    }
}

