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
    
    // Set up the test environment before each test
    override func setUp() {
        super.setUp()
        favoritesManager = FavoritesManager.shared
        // Clear UserDefaults before each test to ensure a clean state
        UserDefaults.standard.removeObject(forKey: "FavoriteMeals")
    }
    
    // Test adding a favorite meal
    func testAddFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.addFavorite(meal: mealDetail)
        
        // Verify that the meal is marked as favorite and the count is correct
        XCTAssertTrue(favoritesManager.isFavorite(meal: mealDetail))
        XCTAssertEqual(favoritesManager.getFavorites().count, 1)
    }
    
    // Test removing a favorite meal
    func testRemoveFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.addFavorite(meal: mealDetail)
        favoritesManager.removeFavorite(meal: mealDetail)
        
        // Verify that the meal is no longer marked as favorite and the count is zero
        XCTAssertFalse(favoritesManager.isFavorite(meal: mealDetail))
        XCTAssertEqual(favoritesManager.getFavorites().count, 0)
    }
    
    // Test retrieving all favorite meals
    func testGetFavorites() {
        let mealDetail1 = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal 1")
        let mealDetail2 = TestUtilities.createMealDetailModel(id: "2", name: "Test Meal 2")
        
        favoritesManager.addFavorite(meal: mealDetail1)
        favoritesManager.addFavorite(meal: mealDetail2)
        
        let favorites = favoritesManager.getFavorites()
        
        // Verify that both meals are in the favorites list
        XCTAssertEqual(favorites.count, 2)
        XCTAssertTrue(favorites.contains(where: { $0.idMeal == "1" }))
        XCTAssertTrue(favorites.contains(where: { $0.idMeal == "2" }))
    }
    
    // Test adding a duplicate favorite meal
    func testAddDuplicateFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.addFavorite(meal: mealDetail)
        favoritesManager.addFavorite(meal: mealDetail)
        
        // Verify that the duplicate is not added and the count remains 1
        XCTAssertEqual(favoritesManager.getFavorites().count, 1)
    }
    
    // Test removing a non-existent favorite meal
    func testRemoveNonExistentFavorite() {
        let mealDetail = TestUtilities.createMealDetailModel(id: "1", name: "Test Meal")
        
        favoritesManager.removeFavorite(meal: mealDetail)
        
        // Verify that removing a non-existent favorite doesn't affect the count
        XCTAssertEqual(favoritesManager.getFavorites().count, 0)
    }
}
