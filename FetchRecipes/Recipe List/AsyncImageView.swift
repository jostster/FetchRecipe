//
//  AsyncImageView.swift
//  FetchRecipes
//
//  Created by Brian Jost on 10/16/24.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var image: UIImage?
    let urlString: String
    let viewModel: RecipeViewModel
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView() // Show a loading indicator while image loads
                    .task {
                        image = await viewModel.loadImage(for: urlString)
                    }
            }
        }
        .frame(width: 100, height: 100)
        .clipped()
    }
}
