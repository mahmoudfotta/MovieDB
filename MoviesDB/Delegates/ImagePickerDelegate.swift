//
//  ImagePickerDelegate.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicked: ((UIImage) -> Void)?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imagePicked?(image)
        picker.dismiss(animated: true)
    }
}
