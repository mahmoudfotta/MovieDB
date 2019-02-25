//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/25/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addPosterImageView()
        addTitleLabel()
        addOverviewLabel()
        addDateLabel()
    }
    
    func addPosterImageView() {
        addSubview(posterImageView)
        posterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        titleLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
    }
    
    func addOverviewLabel() {
        addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
    }
    
    func addDateLabel() {
        addSubview(dateLabel)
//        dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5).isActive = true
        dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
        dateLabel.setContentHuggingPriority(UILayoutPriority(749), for: .vertical)
    }
    
    func updateCell(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        dateLabel.text = movie.date
    }
}
