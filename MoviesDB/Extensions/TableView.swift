//
//  TableView.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/24/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

extension UITableView {
    func isLast(_ indexPath: IndexPath) -> Bool {
        let lastSectionIndex = numberOfSections - 1
        let lastRowIndex = numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            return true
        }
        return false
    }

    func addLoadingIndicator(at indexPath: IndexPath) {
        if isLast(indexPath) {
            tableFooterView = IndicatorView()
            tableFooterView?.isHidden = false
        }
    }
}
