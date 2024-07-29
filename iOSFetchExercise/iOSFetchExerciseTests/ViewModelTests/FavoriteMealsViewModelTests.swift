//
//  FavoriteMealsViewModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/28/24.
//

import XCTest
@testable import iOSFetchExercise

class FavoriteMealsViewModelTests: XCTestCase {
    var viewModel: FavoriteMealsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = FavoriteMealsViewModel()
        clearAllFavorites()
    }
    
    override func tearDown() {
        clearAllFavorites()
        super.tearDown()
    }
    
    func testLoadFavorites() {
        let meal1 = createMealDetailModel(id: "1", name: "Apple Pie")
        let meal2 = createMealDetailModel(id: "2", name: "Chocolate Cake")
        FavoritesManager.shared.addFavorite(meal: meal1)
        FavoritesManager.shared.addFavorite(meal: meal2)
        
        viewModel.loadFavorites()
        
        XCTAssertEqual(viewModel.favoriteMeals.count, 2)
        XCTAssertTrue(viewModel.favoriteMeals.contains { $0.idMeal == "1" && $0.strMeal == "Apple Pie" })
        XCTAssertTrue(viewModel.favoriteMeals.contains { $0.idMeal == "2" && $0.strMeal == "Chocolate Cake" })
    }
    
    func testFilteredMealsEmptySearchText() {
        let meal1 = createMealDetailModel(id: "1", name: "Apple Pie")
        let meal2 = createMealDetailModel(id: "2", name: "Chocolate Cake")
        FavoritesManager.shared.addFavorite(meal: meal1)
        FavoritesManager.shared.addFavorite(meal: meal2)
        
        viewModel.loadFavorites()
        let filtered = viewModel.filteredMeals(searchText: "")
        
        XCTAssertEqual(filtered.count, 2)
    }
    
    func testFilteredMealsWithSearchText() {
        let meal1 = createMealDetailModel(id: "1", name: "Apple Pie")
        let meal2 = createMealDetailModel(id: "2", name: "Chocolate Cake")
        FavoritesManager.shared.addFavorite(meal: meal1)
        FavoritesManager.shared.addFavorite(meal: meal2)
        
        viewModel.loadFavorites()
        let filtered = viewModel.filteredMeals(searchText: "apple")
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.strMeal, "Apple Pie")
    }
    
    private func createMealDetailModel(id: String, name: String) -> MealDetailModel {
        let json = """
        {
            "idMeal": "\(id)",
            "strMeal": "\(name)",
            "strInstructions": "Test Instructions",
            "strMealThumb": "https://example.com/thumb.jpg",
            "strIngredient1": "Ingredient1",
            "strMeasure1": "Measure1"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        return try! decoder.decode(MealDetailModel.self, from: json)
    }
    
    private func clearAllFavorites() {
        let favorites = FavoritesManager.shared.getFavorites()
        for favorite in favorites {
            let meal = createMealDetailModel(id: favorite.idMeal, name: favorite.strMeal)
            FavoritesManager.shared.removeFavorite(meal: meal)
        }
    }
}
