//
//  MealsViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

// MARK: - MealsViewModel

/// ViewModel for handling the list of meals
class MealsViewModel: ObservableObject {
    // Published properties to update the UI when changed
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String?
    
    /// Fetches the list of dessert meals from the API
    func fetchMeals() async {
        do {
            // Construct the URL for the API request
            let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
            
            // Perform the network request
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the response data
            let response = try JSONDecoder().decode(MealResponse.self, from: data)
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                // Sort the meals alphabetically by name before assigning
                self.meals = response.meals.sorted { $0.strMeal < $1.strMeal }
            }
        } catch {
            // Handle any errors and update the UI on the main thread
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    /// Filters the meals based on the search text
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
