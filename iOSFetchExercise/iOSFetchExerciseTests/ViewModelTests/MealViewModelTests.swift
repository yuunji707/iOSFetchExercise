//
//  MealViewModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/25/24.
//

import XCTest
@testable import iOSFetchExercise

class MealViewModelTests: XCTestCase {
    var viewModel: MealsViewModel!

    override func setUp() {
        super.setUp()
        MockAPIService.resetMockShared()
        viewModel = MealsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchMeals_Success() async {
        // This test should:
        // 1. Set up the MockAPIService to return a successful result (an array of MealModels)
        // 2. Call viewModel.fetchMeals()
        // 3. Assert that:
        //    - viewModel.meals contains the expected meals
        //    - viewModel.errorMessage is nil
    }

    func testFetchMeals_Failure() async {
        // This test should:
        // 1. Set up the MockAPIService to simulate a failure (throw an error)
        // 2. Call viewModel.fetchMeals()
        // 3. Assert that:
        //    - viewModel.meals is empty
        //    - viewModel.errorMessage is not nil and contains an error message
    }

    func testFilteredMeals_EmptySearchText() {
        // This test should:
        // 1. Set up viewModel.meals with a test array of MealModels
        // 2. Call viewModel.filteredMeals(searchText: "")
        // 3. Assert that the returned array is equal to the original meals array
    }

    func testFilteredMeals_WithSearchText() {
        // This test should:
        // 1. Set up viewModel.meals with a test array of MealModels
        // 2. Call viewModel.filteredMeals(searchText: "someSearchText")
        // 3. Assert that the returned array contains only meals whose names include the search text
    }

    func testFilteredMeals_NoMatchingResults() {
        // This test should:
        // 1. Set up viewModel.meals with a test array of MealModels
        // 2. Call viewModel.filteredMeals(searchText: "nonExistentMeal")
        // 3. Assert that the returned array is empty
    }
}
