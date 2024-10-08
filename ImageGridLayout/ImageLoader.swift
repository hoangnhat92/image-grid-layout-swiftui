//
//  ImageLoader.swift
//  ImageGridLayout
//
//  Created by nhat on 8/10/24.
//
import SwiftUI

class ImageLoader: ObservableObject {
     
    @Published var image: Image? = nil
    
    @Published var isLoading: Bool = true
    
    private let url: URL
    
    private let uuid: String
    
    init(url: URL, uuid: String) {
        self.url = url
        self.uuid = uuid        
        loadImage()
    }
    
    func loadImage() {
        
        // Check the cache first
        if let cachedImage = ImageCache.shared.getImage(forKey: uuid) {
            self.image = Image(uiImage: cachedImage)
            self.isLoading = false
            return
        }
        
        // If not cached, fetch the image from the network
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    await setImage(uiImage: uiImage)
                    ImageCache.shared
                        .setImage(uiImage, forKey: uuid) // Cache the image
                } else {
                    await setLoadingState(isLoading: false)
                }
            } catch {
                await setLoadingState(isLoading: false)

            }
        }
    }
    
    @MainActor
      private func setImage(uiImage: UIImage) {
          self.image = Image(uiImage: uiImage)
          self.isLoading = false
      }
      
      @MainActor
      private func setLoadingState(isLoading: Bool) {
          self.isLoading = isLoading
      }
}
