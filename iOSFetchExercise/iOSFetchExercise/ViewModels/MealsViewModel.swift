//
//  MealsViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

// MARK: - MealsViewModel

/// ViewModel for managing a list of meals
class MealsViewModel: ObservableObject {
    /// Published property to store and update the list of meals
    @Published var meals: [MealModel] = []
    /// Published property to store and update error messages
    @Published var errorMessage: String?
    
    /// Instance of APIService to fetch meals
    private let apiService = APIService.shared

    /// Fetches meals from the API
    func fetchMeals() async {
        do {
            let fetchedMeals = try await apiService.fetchMeals()
            DispatchQueue.main.async {
                self.meals = fetchedMeals
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    /// Filters meals based on search text
    /// - Parameter searchText: The text to filter meals by
    /// - Returns: An array of filtered MealModel objects
    func filteredMeals(searchText: String) -> [MealModel] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }
}
