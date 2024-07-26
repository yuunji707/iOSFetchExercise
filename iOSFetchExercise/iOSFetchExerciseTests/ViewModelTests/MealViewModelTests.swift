//
//  MealViewModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/25/24.
//

import XCTest
@testable import iOSFetchExercise

class MealsViewModelTests: XCTestCase {
    var viewModel: MealsViewModel!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockURLSession = MockURLSession()
        viewModel = MealsViewModel()
        viewModel.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockURLSession = nil
        try super.tearDownWithError()
    }

    func testFetchMealsSuccess() async throws {
        // Given
        let jsonString = """
        {
            "meals": [
                {"idMeal": "1", "strMeal": "Banana Dessert", "strMealThumb": "https://example.com/1.jpg"},
                {"idMeal": "2", "strMeal": "Apple Pie", "strMealThumb": "https://example.com/2.jpg"}
            ]
        }
        """
        mockURLSession.setDataToReturn(jsonString.data(using: .utf8))

        // When
        await viewModel.fetchMeals()

        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.meals.count, 2, "Should have fetched 2 meals")
            XCTAssertEqual(viewModel.meals[0].strMeal, "Apple Pie", "First meal should be Apple Pie (sorted alphabetically)")
            XCTAssertEqual(viewModel.meals[1].strMeal, "Banana Dessert", "Second meal should be Banana Dessert (sorted alphabetically)")
            XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success")
        }
    }

    func testFetchMealsFailure() async throws {
        // Given
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error message"])
        mockURLSession.setErrorToThrow(expectedError)

        // When
        await viewModel.fetchMeals()

        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.meals.isEmpty, "Meals array should be empty on error")
            XCTAssertEqual(viewModel.errorMessage, "Test error message", "Error message should match the thrown error")
        }
    }

    func testFilteredMeals() {
        // Given
        viewModel.meals = [
            MealModel(idMeal: "1", strMeal: "Apple Pie", strMealThumb: "https://example.com/1.jpg"),
            MealModel(idMeal: "2", strMeal: "Banana Bread", strMealThumb: "https://example.com/2.jpg"),
            MealModel(idMeal: "3", strMeal: "Chocolate Cake", strMealThumb: "https://example.com/3.jpg")
        ]

        // When & Then
        XCTAssertEqual(viewModel.filteredMeals(searchText: "").count, 3, "All meals should be returned when search is empty")
        XCTAssertEqual(viewModel.filteredMeals(searchText: "Apple").count, 1, "One meal should match 'Apple'")
        XCTAssertEqual(viewModel.filteredMeals(searchText: "a").count, 3, "All meals contain 'a'")
        XCTAssertEqual(viewModel.filteredMeals(searchText: "Muffin").count, 0, "No meals should match 'Muffin'")
    }
}
