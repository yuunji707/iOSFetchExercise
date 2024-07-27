//
//  FavoritesManager.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteMeals"
    
    private init() {}
    
    func getFavorites() -> [MealModel] {
        guard let data = userDefaults.data(forKey: favoritesKey) else { return [] }
        return (try? JSONDecoder().decode([MealModel].self, from: data)) ?? []
    }
    
    func addFavorite(meal: MealDetailModel) {
        var favorites = getFavorites()
        let simpleMeal = MealModel(idMeal: meal.idMeal, strMeal: meal.strMeal, strMealThumb: meal.strMealThumb)
        if !favorites.contains(where: { $0.idMeal == meal.idMeal }) {
            favorites.append(simpleMeal)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(meal: MealDetailModel) {
        var favorites = getFavorites()
        favorites.removeAll { $0.idMeal == meal.idMeal }
        saveFavorites(favorites)
    }
    
    func isFavorite(meal: MealDetailModel) -> Bool {
        getFavorites().contains { $0.idMeal == meal.idMeal }
    }
    
    private func saveFavorites(_ favorites: [MealModel]) {
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
