//
//  FetchRecipesTests.swift
//  FetchRecipesTests
//
//  Created by Brian Jost on 10/16/24.
//

import XCTest
@testable import FetchRecipes

final class FetchRecipesTests: XCTestCase {
    private var viewModel = RecipeViewModel()

    func testFetchRecipes() async throws {
        do {
            try await viewModel.fetchRecipes()
            XCTAssert(!viewModel.recipes.isEmpty)
        } catch {
            XCTFail("Fetch recipes failed")
        }
    }
    
    func testAsyncImageCachePass() async throws {
        let image = await viewModel.loadImage(for: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b2879d3a-b145-4618-9c1d-fd3a451d0739/small.jpg")
        let cachedImage = viewModel.imageCache.object(forKey: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b2879d3a-b145-4618-9c1d-fd3a451d0739/small.jpg")
        XCTAssert(image == cachedImage)
    }
    
    func testAsyncImageNotInCash() async throws {
        let image = await viewModel.loadImage(for: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b2879d3a-b145-4618-9c1d-fd3a451d0739/small.jpg")
        let cachedImage = viewModel.imageCache.object(forKey: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/def8c76f-9054-40ff-8021-7f39148ad4b7/small.jpg")
        XCTAssert(image != cachedImage)
    }
}
