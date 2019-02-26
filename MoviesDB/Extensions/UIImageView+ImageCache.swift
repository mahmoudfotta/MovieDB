//
//  UIImageView+ImageCache.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func cacheImage(with urlString: String, and session: URLSession = .shared, into cache: NSCache<AnyObject, AnyObject> = imageCache, completed: (() -> Void)? = nil) {
        image = nil
        if let imageFromCache = cache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        let apiManager = ApiManager(session: session, endpoint: .image(path: urlString))
        apiManager.getImage(onSuccess: { (imageData) in
            if let imageToCache = UIImage(data: imageData) {
                cache.setObject(imageToCache, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                   self.image = imageToCache
                    completed?()
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                let imageToCache = #imageLiteral(resourceName: "Poster_not_available")
                cache.setObject(imageToCache, forKey: urlString as AnyObject)
                self.image = imageToCache
                completed?()
            }
        }
    }
}
