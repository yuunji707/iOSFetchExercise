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
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        viewModel = MealDetailViewModel()
        viewModel.urlSession = mockURLSession
    }
    
    override func tearDown() {
        viewModel = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchMealDetailSuccess() async throws {
        // Prepare mock response
        let jsonString = """
        {
            "meals": [
                {
                    "idMeal": "12345",
                    "strMeal": "Test Meal",
                    "strInstructions": "Test instructions",
                    "strMealThumb": "https://example.com/meal.jpg",
                    "strYoutube": "https://youtube.com/watch?v=12345",
                    "strSource": "https://example.com/source",
                    "strTags": "Tag1,Tag2,Tag3",
                    "strArea": "TestArea",
                    "strIngredient1": "Ingredient1",
                    "strMeasure1": "100g",
                    "strIngredient2": "Ingredient2",
                    "strMeasure2": "200ml"
                }
            ]
        }
        """
        mockURLSession.dataToReturn = jsonString.data(using: .utf8)
        
        // Call the method
        await viewModel.fetchMealDetail(id: "12345")
        
        // Assert the results
        XCTAssertNotNil(viewModel.mealDetail)
        XCTAssertEqual(viewModel.mealDetail?.idMeal, "12345")
        XCTAssertEqual(viewModel.mealDetail?.strMeal, "Test Meal")
        XCTAssertEqual(viewModel.mealDetail?.strInstructions, "Test instructions")
        XCTAssertEqual(viewModel.mealDetail?.strMealThumb, "https://example.com/meal.jpg")
        XCTAssertEqual(viewModel.mealDetail?.strYoutube, "https://youtube.com/watch?v=12345")
        XCTAssertEqual(viewModel.mealDetail?.strSource, "https://example.com/source")
        XCTAssertEqual(viewModel.mealDetail?.strTags, "Tag1,Tag2,Tag3")
        XCTAssertEqual(viewModel.mealDetail?.strArea, "TestArea")
        XCTAssertEqual(viewModel.mealDetail?.ingredientsWithMeasurements.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchMealDetailFailure() async throws {
        // Prepare mock error
        mockURLSession.errorToThrow = NSError(domain: "TestError", code: 0, userInfo: nil)
        
        // Call the method
        await viewModel.fetchMealDetail(id: "12345")
        
        // Assert the results
        XCTAssertNil(viewModel.mealDetail)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
