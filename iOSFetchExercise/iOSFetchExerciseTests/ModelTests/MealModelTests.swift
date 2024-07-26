//
//  MealModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/25/24.
//

import XCTest
@testable import iOSFetchExercise

class MealModelTests: XCTestCase {
    func testMealModelDecoding() throws {
        let json = """
        {
            "idMeal": "12345",
            "strMeal": "Test Meal",
            "strMealThumb": "https://example.com/meal.jpg"
        }
        """
        let data = json.data(using: .utf8)!
        let meal = try JSONDecoder().decode(MealModel.self, from: data)
        
        XCTAssertEqual(meal.id, "12345")
        XCTAssertEqual(meal.idMeal, "12345")
        XCTAssertEqual(meal.strMeal, "Test Meal")
        XCTAssertEqual(meal.strMealThumb, "https://example.com/meal.jpg")
    }
    
    func testMealResponseDecoding() throws {
        let json = """
        {
            "meals": [
                {
                    "idMeal": "12345",
                    "strMeal": "Test Meal 1",
                    "strMealThumb": "https://example.com/meal1.jpg"
                },
                {
                    "idMeal": "67890",
                    "strMeal": "Test Meal 2",
                    "strMealThumb": "https://example.com/meal2.jpg"
                }
            ]
        }
        """
        let data = json.data(using: .utf8)!
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        
        XCTAssertEqual(response.meals.count, 2)
        XCTAssertEqual(response.meals[0].idMeal, "12345")
        XCTAssertEqual(response.meals[1].idMeal, "67890")
    }
}
