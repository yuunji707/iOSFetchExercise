//
//  MealsViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

class MealsViewModel: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String?
    
    func fetchMeals() async {
        do {
            let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MealResponse.self, from: data)
            DispatchQueue.main.async {
                self.meals = response.meals.sorted { $0.strMeal < $1.strMeal }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
