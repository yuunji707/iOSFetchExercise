//
//  FavoritesManagerTest.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/28/24.
//

import XCTest
@testable import iOSFetchExercise

class FavoritesManagerTests: XCTestCase {
    
    var favoritesManager: FavoritesManager!
    
    override func setUp() {
        super.setUp()
        favoritesManager = FavoritesManager.shared
        // Clear UserDefaults before each test
        UserDefaults.standard.removeObject(forKey: "FavoriteMeals")
    }
    
    func testAddFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.addFavorite(meal: mealDetail)
        
        XCTAssertTrue(favoritesManager.isFavorite(meal: mealDetail))
        XCTAssertEqual(favoritesManager.getFavorites().count, 1)
    }
    
    func testRemoveFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.addFavorite(meal: mealDetail)
        favoritesManager.removeFavorite(meal: mealDetail)
        
        XCTAssertFalse(favoritesManager.isFavorite(meal: mealDetail))
        XCTAssertEqual(favoritesManager.getFavorites().count, 0)
    }
    
    func testGetFavorites() {
        let mealDetail1 = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal 1")
        let mealDetail2 = TestUtilities.createMealDetailModel(id: "2", name: "Test Meal 2")
        
        favoritesManager.addFavorite(meal: mealDetail1)
        favoritesManager.addFavorite(meal: mealDetail2)
        
        let favorites = favoritesManager.getFavorites()
        
        XCTAssertEqual(favorites.count, 2)
        XCTAssertTrue(favorites.contains(where: { $0.idMeal == "1" }))
        XCTAssertTrue(favorites.contains(where: { $0.idMeal == "2" }))
    }
    
    func testAddDuplicateFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.addFavorite(meal: mealDetail)
        favoritesManager.addFavorite(meal: mealDetail)
        
        XCTAssertEqual(favoritesManager.getFavorites().count, 1)
    }
    
    func testRemoveNonExistentFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.removeFavorite(meal: mealDetail)
        
        XCTAssertEqual(favoritesManager.getFavorites().count, 0)
    }
}
