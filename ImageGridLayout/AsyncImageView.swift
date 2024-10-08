//
//  RedirectHandlingImageView.swift
//  ImageGridLayout
//
//  Created by nhat on 8/10/24.
//
import SwiftUI

struct AsyncImageView: View {
    
    @StateObject private var imageLoader: ImageLoader
    
    init(url: URL, uuid: String = UUID().uuidString) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url, uuid: uuid))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if imageLoader.isLoading {
                // Show a loading indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                // Placeholder image
                Image(systemName: "photo")
            }
        }
    }
}
