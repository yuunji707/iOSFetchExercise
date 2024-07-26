//
//  MealDetailModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/25/24.
//

import XCTest
@testable import iOSFetchExercise


class MealDetailModelTests: XCTestCase {
    func testMealDetailModelDecoding() throws {
        let json = """
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
            "strMeasure2": "200ml",
            "strIngredient3": "",
            "strMeasure3": ""
        }
        """
        let data = json.data(using: .utf8)!
        let mealDetail = try JSONDecoder().decode(MealDetailModel.self, from: data)
        
        XCTAssertEqual(mealDetail.id, "12345")
        XCTAssertEqual(mealDetail.idMeal, "12345")
        XCTAssertEqual(mealDetail.strMeal, "Test Meal")
        XCTAssertEqual(mealDetail.strInstructions, "Test instructions")
        XCTAssertEqual(mealDetail.strMealThumb, "https://example.com/meal.jpg")
        XCTAssertEqual(mealDetail.strYoutube, "https://youtube.com/watch?v=12345")
        XCTAssertEqual(mealDetail.strSource, "https://example.com/source")
        XCTAssertEqual(mealDetail.strTags, "Tag1,Tag2,Tag3")
        XCTAssertEqual(mealDetail.strArea, "TestArea")
        
        XCTAssertEqual(mealDetail.ingredientsWithMeasurements.count, 2)
        XCTAssertEqual(mealDetail.ingredientsWithMeasurements[0].0, "Ingredient1")
        XCTAssertEqual(mealDetail.ingredientsWithMeasurements[0].1, "100g")
        XCTAssertEqual(mealDetail.ingredientsWithMeasurements[1].0, "Ingredient2")
        XCTAssertEqual(mealDetail.ingredientsWithMeasurements[1].1, "200ml")
        
        XCTAssertEqual(mealDetail.tagsArray, ["Tag1", "Tag2", "Tag3"])
    }
    
    func testMealDetailModelEncoding() throws {
            // Create a JSON string representing a MealDetailModel
            let json = """
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
            """
            
            // Decode the JSON string into a MealDetailModel
            let decoder = JSONDecoder()
            let data = json.data(using: .utf8)!
            let mealDetail = try decoder.decode(MealDetailModel.self, from: data)
            
            // Now encode the mealDetail back to JSON
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(mealDetail)
            
            // Decode the encoded data back into a MealDetailModel
            let decodedMealDetail = try decoder.decode(MealDetailModel.self, from: encodedData)
            
            // Assert that the original and re-decoded models are equal
            XCTAssertEqual(decodedMealDetail.id, mealDetail.id)
            XCTAssertEqual(decodedMealDetail.strMeal, mealDetail.strMeal)
            XCTAssertEqual(decodedMealDetail.strInstructions, mealDetail.strInstructions)
            XCTAssertEqual(decodedMealDetail.strMealThumb, mealDetail.strMealThumb)
            XCTAssertEqual(decodedMealDetail.strYoutube, mealDetail.strYoutube)
            XCTAssertEqual(decodedMealDetail.strSource, mealDetail.strSource)
            XCTAssertEqual(decodedMealDetail.strTags, mealDetail.strTags)
            XCTAssertEqual(decodedMealDetail.strArea, mealDetail.strArea)
            
            // Compare ingredientsWithMeasurements manually
            XCTAssertEqual(decodedMealDetail.ingredientsWithMeasurements.count, mealDetail.ingredientsWithMeasurements.count)
            for (index, originalPair) in mealDetail.ingredientsWithMeasurements.enumerated() {
                let decodedPair = decodedMealDetail.ingredientsWithMeasurements[index]
                XCTAssertEqual(originalPair.0, decodedPair.0, "Ingredient at index \(index) doesn't match")
                XCTAssertEqual(originalPair.1, decodedPair.1, "Measurement at index \(index) doesn't match")
            }
        }
}
