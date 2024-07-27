//
//  FavoritesManager.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import Foundation

// MARK: - FavoritesManager

/// Manages the user's favorite meals using UserDefaults for persistence
class FavoritesManager {
    // Singleton instance for global access
    static let shared = FavoritesManager()
    
    // UserDefaults instance for data storage
    private let userDefaults = UserDefaults.standard
    // Key used to store favorites in UserDefaults
    private let favoritesKey = "FavoriteMeals"
    
    // Private initializer to ensure singleton usage
    private init() {}
    
    /// Retrieves the list of favorite meals from UserDefaults
    /// - Returns: An array of MealModel objects representing favorite meals
    func getFavorites() -> [MealModel] {
        guard let data = userDefaults.data(forKey: favoritesKey) else { return [] }
        return (try? JSONDecoder().decode([MealModel].self, from: data)) ?? []
    }
    
    /// Adds a meal to the favorites list
    /// - Parameter meal: The MealDetailModel to be added to favorites
    func addFavorite(meal: MealDetailModel) {
        var favorites = getFavorites()
        // Create a simplified MealModel from the detailed meal
        let simpleMeal = MealModel(idMeal: meal.idMeal, strMeal: meal.strMeal, strMealThumb: meal.strMealThumb)
        // Add the meal if it's not already in favorites
        if !favorites.contains(where: { $0.idMeal == meal.idMeal }) {
            favorites.append(simpleMeal)
            saveFavorites(favorites)
        }
    }
    
    /// Removes a meal from the favorites list
    /// - Parameter meal: The MealDetailModel to be removed from favorites
    func removeFavorite(meal: MealDetailModel) {
        var favorites = getFavorites()
        favorites.removeAll { $0.idMeal == meal.idMeal }
        saveFavorites(favorites)
    }
    
    /// Checks if a meal is in the favorites list
    /// - Parameter meal: The MealDetailModel to check
    /// - Returns: A boolean indicating whether the meal is a favorite
    func isFavorite(meal: MealDetailModel) -> Bool {
        getFavorites().contains { $0.idMeal == meal.idMeal }
    }
    
    /// Saves the current list of favorites to UserDefaults
    /// - Parameter favorites: The array of MealModel objects to be saved
    private func saveFavorites(_ favorites: [MealModel]) {
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
