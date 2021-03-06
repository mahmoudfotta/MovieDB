//
//  AddMovieView.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/24/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class AddMovieView: UIView {
    var selectImageAction: (() -> Void)?

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Title"
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.accessibilityIdentifier = "titleTextField"
        return textField
    }()
    
    let overviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Overview"
        label.accessibilityIdentifier = "overviewLabel"
        return label
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.accessibilityIdentifier = "overviewTextView"
        return textView
    }()
    
    let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Choose data"
        label.accessibilityIdentifier = "dateLabel"
        return label
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "5/9/1993"
        textField.accessibilityIdentifier = "dateTextField"
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addScrollView()
        addSelectedImageView()
        addSelectImageView()
        addTitleStackView()
        addDateStackView()
        addOverviewStackView()
        
        addDatePicker(to: dateTextField)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    func addScrollView() {
        addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        scrollView.addSubview(topView)
        topView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        scrollView.handleKeyboard()
    }

    func addSelectedImageView() {
        addSubview(selectedImageView)
        selectedImageView.centerXAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerXAnchor, constant: -30).isActive = true
        selectedImageView.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        selectedImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        selectedImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    func addSelectImageView() {
        topView.addSubview(selectImageView)
        selectImageView.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor).isActive = true
        selectImageView.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: 10).isActive = true
        selectImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImageTapped))
        selectImageView.addGestureRecognizer(tapGesture)
    }

    @objc func selectImageTapped() {
        selectImageAction?()
    }

    func addTitleStackView() {
        topView.addSubview(titleStackView)
        titleStackView.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        titleStackView.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 15).isActive = true
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
    }

    func addDateStackView() {
        topView.addSubview(dateStackView)
        dateStackView.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        dateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 15).isActive = true
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateTextField)
    }

    func addOverviewStackView() {
        topView.addSubview(overviewStackView)
        overviewStackView.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        overviewStackView.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        overviewStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 15).isActive = true
        overviewStackView.addArrangedSubview(overviewLabel)
        overviewStackView.addArrangedSubview(overviewTextView)
        overviewTextView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        overviewTextView.layer.borderWidth = 1
        overviewTextView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        overviewTextView.layer.cornerRadius = 4
    }

    func addDatePicker(to textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDateChanged), for: .valueChanged)
        textField.inputView = datePicker
    }

    @objc func handleDateChanged(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
