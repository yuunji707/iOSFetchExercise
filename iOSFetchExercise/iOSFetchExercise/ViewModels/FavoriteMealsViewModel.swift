//
//  FavoriteMealsViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// ViewModel for managing favorite meals
class FavoriteMealsViewModel: ObservableObject {
    /// Published property to store and update favorite meals
    @Published var favoriteMeals: [MealModel] = []
    
    /// Instance of FavoritesManager to handle favorite meals persistence
    private let favoritesManager = FavoritesManager.shared
    
    /// Loads favorite meals from FavoritesManager
    func loadFavorites() {
        favoriteMeals = favoritesManager.getFavorites()
    }
    
    /// Filters meals based on search text
    /// - Parameter searchText: The text to filter meals by
    /// - Returns: An array of filtered MealModel objects
    func filteredMeals(searchText: String) -> [MealModel] {
        if searchText.isEmpty {
            return favoriteMeals
        } else {
            return favoriteMeals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }
}
