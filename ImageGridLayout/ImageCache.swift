//
//  ImageCache.swift
//  ImageGridLayout
//
//  Created by nhat on 8/10/24.

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func clearAllImages() {
        cache.removeAllObjects()
    }
}
