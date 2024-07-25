//
//  MealModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

struct MealModel: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}

struct MealResponse: Codable {
    let meals: [MealModel]
}
