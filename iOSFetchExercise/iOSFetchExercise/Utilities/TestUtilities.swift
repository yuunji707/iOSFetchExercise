//
//  TestUtilities.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/29/24.
//

import Foundation

struct TestUtilities {
    // MARK: - Model Creation

    static func createMealDetailModel(id: String, name: String) -> MealDetailModel {
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

}
