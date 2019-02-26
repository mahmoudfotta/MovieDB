//
//  ScrollView+Keyboard.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

extension UIScrollView {
    func handleKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            contentInset = UIEdgeInsets.zero
        } else {
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollIndicatorInsets = contentInset
    }
}
