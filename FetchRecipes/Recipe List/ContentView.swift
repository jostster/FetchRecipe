//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Brian Jost on 10/16/24.
//

import Foundation
import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel = RecipeViewModel()
    @State var error: RecipeError? = .failedToLoad
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let error = error {
                    Text(error.localizedDescription)
                } else {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            recipeItem(recipe)
                        }
                    }
                }
            }
            .refreshable {
                await fetchRecipes()
            }
            .task {
                await fetchRecipes()
            }
            .navigationTitle(Text("Recipes")) // Use text so it automatically handles localization
        }
    }
    
    func recipeItem(_ recipe: Recipe) -> some View {
        
        HStack {
            AsyncImageView(urlString: recipe.imageUrlSmall, viewModel: viewModel)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .padding(.leading, 8)
                HStack {
                    Text("Cuisine:")
                        .padding(.leading, 8)
                    Text(recipe.cuisine)
                        .font(.callout)
                }
                
                HStack {
                    if let youtubeUrlString = recipe.youtubeUrl,
                       let youtubeUrl = URL(string: youtubeUrlString) {
                        Button(action: {
                            openURL(youtubeUrl)
                        }) {
                            Label(String(localized: "Youtube"), systemImage: "play.rectangle")
                        }
                        .tint(.red)
                    }
                    
                    if let sourceUrlString = recipe.sourceUrl,
                       let sourceUrl = URL(string: sourceUrlString) {
                        Button(action: {
                            openURL(sourceUrl)
                        }) {
                            Label(String(localized: "Website"), systemImage: "richtext.page")
                        }
                        .tint(.blue)
                    }
                }
                .padding(.leading, 8)
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                
            }
        }
        .padding()
    }
    
    func fetchRecipes() async {
        do {
            try await viewModel.fetchRecipes()
            error = nil
        } catch {
            self.error = error as? RecipeError
        }
    }
}

#Preview {
    RecipeListView()
}
