//
//  MealDetailViewModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/25/24.
//


import XCTest
@testable import iOSFetchExercise

class MealDetailViewModelTests: XCTestCase {
    var viewModel: MealDetailViewModel!

    override func setUp() {
        super.setUp()
        MockAPIService.resetMockShared()
        viewModel = MealDetailViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchMealDetail_Success() async {
        // This test should:
        // 1. Set up the MockAPIService to return a successful result (a MealDetailModel)
        // 2. Call viewModel.fetchMealDetail(id: "someId")
        // 3. Assert that:
        //    - viewModel.mealDetail is set to the expected meal detail
        //    - viewModel.errorMessage is nil
    }

    func testFetchMealDetail_Failure() async {
        // This test should:
        // 1. Set up the MockAPIService to simulate a failure (throw an error)
        // 2. Call viewModel.fetchMealDetail(id: "someId")
        // 3. Assert that:
        //    - viewModel.mealDetail is nil
        //    - viewModel.errorMessage is not nil and contains an error message
    }

    func testCheckFavoriteStatus_IsFavorite() {
        // This test should:
        // 1. Set up viewModel.mealDetail with a test MealDetailModel
        // 2. Add the meal to favorites using FavoritesManager.shared
        // 3. Call viewModel.checkFavoriteStatus()
        // 4. Assert that viewModel.isFavorite is true
        // 5. Clean up by removing the meal from favorites
    }

    func testCheckFavoriteStatus_IsNotFavorite() {
        // This test should:
        // 1. Set up viewModel.mealDetail with a test MealDetailModel
        // 2. Ensure the meal is not in favorites using FavoritesManager.shared
        // 3. Call viewModel.checkFavoriteStatus()
        // 4. Assert that viewModel.isFavorite is false
    }

    func testToggleFavorite_AddToFavorites() {
        // This test should:
        // 1. Set up viewModel.mealDetail with a test MealDetailModel
        // 2. Ensure the meal is not in favorites
        // 3. Call viewModel.toggleFavorite()
        // 4. Assert that:
        //    - viewModel.isFavorite is now true
        //    - The meal is in the favorites list of FavoritesManager.shared
        // 5. Clean up by removing the meal from favorites
    }

    func testToggleFavorite_RemoveFromFavorites() {
        // This test should:
        // 1. Set up viewModel.mealDetail with a test MealDetailModel
        // 2. Add the meal to favorites
        // 3. Call viewModel.toggleFavorite()
        // 4. Assert that:
        //    - viewModel.isFavorite is now false
        //    - The meal is not in the favorites list of FavoritesManager.shared
    }
}
