//
//  MealsViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

// MARK: - MealsViewModel

class MealsViewModel: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared

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
    
    func filteredMeals(searchText: String) -> [MealModel] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }
}


