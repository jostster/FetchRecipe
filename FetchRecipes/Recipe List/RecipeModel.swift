//
//  RecipeModel.swift
//  FetchRecipes
//
//  Created by Brian Jost on 10/16/24.
//

import Foundation

struct Recipe: Codable {
    var id: String
    var name: String
    var cuisine: String
    var imageUrlLarge: String
    var imageUrlSmall: String
    var sourceUrl: String?
    var youtubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case imageUrlLarge = "photo_url_large"
        case imageUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

enum RecipeError: Error {
    case failedToLoad
    case failedToParse
    case noRecipes
    
    var localizedDescription: String {
        switch self {
        case .failedToLoad:
            return String(localized: "We ran into an issue while loading the recipes.")
        case .failedToParse:
            return String(localized: "We ran into an issue while parsing the recipes.")
        case .noRecipes:
            return String(localized: "No recipes found.")
        }
    }
}
