//
//  RecipeViewModel.swift
//  FetchRecipes
//
//  Created by Brian Jost on 10/16/24.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    internal let imageCache = NSCache<NSString, UIImage>()

    
    @MainActor func fetchRecipes() async throws {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            print("Invalid URL")
            return
        }
        print("Fetching recipes...")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let encodedRecipes = try JSONSerialization.data(withJSONObject:json?["recipes"] as Any)
            let decodedRecipes = try JSONDecoder().decode([Recipe].self, from: encodedRecipes)
            self.recipes = decodedRecipes
            if recipes.isEmpty {
                throw RecipeError.noRecipes
            }
        } catch let error as DecodingError {
            print("Failed to parse recipes: \(error)")
            self.recipes = []
            throw RecipeError.failedToParse
        } catch let error as URLError {
            print("Failed to fetch recipes: \(error)")
            self.recipes = []
            throw RecipeError.failedToLoad
        }
    }
    
    func loadImage(for urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            print("Cached image: \(urlString)")
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as NSString)
                return image
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        return nil
    }
}

