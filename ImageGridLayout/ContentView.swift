//
//  ContentView.swift
//  ImageGridLayout
//
//  Created by nhat on 8/10/24.
//

import SwiftData
import SwiftUI

struct ImageData: Identifiable {
    let url: String
    let uuid: String = UUID().uuidString    
    var id: String { uuid }
}

struct ContentView: View {

    private let baseImageUrl = "https://loremflickr.com/200/200/"
    private let gridSize = 70
    private let rowCount = 7
        
    // This value will be dynamically calculated based on screen height
    @State private var gridItemSize: CGFloat = 50
    
    @State private var items: [ImageData] = []

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom
            let calculatedItemSize = screenHeight / CGFloat(rowCount) - 2
            let rows = Array(repeating: GridItem(.fixed(calculatedItemSize)), count: rowCount)
            
            NavigationView {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, alignment: .top, spacing: 2) {
                        ForEach(items) { item in
                            AsyncImageView(url: URL(string: item.url)! ,uuid: item.uuid)
                                .frame(width: calculatedItemSize, height: calculatedItemSize)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        }
                    }
                }
                .navigationTitle("Async Image Grid")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing: HStack {
                        Button(action: reloadImages) {
                            Image(systemName: "arrow.clockwise")
                        }
                        Button(action: addNewImage) {
                            Image(systemName: "plus")
                        }
                    }
                )
            }
            .onAppear {
                gridItemSize = screenHeight / CGFloat(rowCount) - 2
                loadInitialImages()
            }
            .padding(.bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func loadInitialImages() {
           items = (0..<gridSize).map { _ in ImageData(url: baseImageUrl) }
    }
    
    private func reloadImages() {
        ImageCache.shared.clearAllImages()
        items.removeAll()
        loadInitialImages()
    }
    
    private func addNewImage() {
        items.append(ImageData(url: baseImageUrl))
    }
}
#Preview {
    NavigationStack {
        ContentView()
    }
}
