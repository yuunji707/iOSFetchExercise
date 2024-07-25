//
//  MealModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

// MARK: - MealModel

/// Represents basic information about a meal
struct MealModel: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    // Conform to Identifiable protocol
    var id: String { idMeal }
}

// MARK: - MealResponse

/// Wrapper struct for API response containing an array of meals
struct MealResponse: Codable {
    let meals: [MealModel]
}
