//
//  FavoriteMealsViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

class FavoriteMealsViewModel: ObservableObject {
    @Published var favoriteMeals: [MealModel] = []
    
    private let favoritesManager = FavoritesManager.shared
    
    func loadFavorites() {
        favoriteMeals = favoritesManager.getFavorites()
    }
    
    func filteredMeals(searchText: String) -> [MealModel] {
        if searchText.isEmpty {
            return favoriteMeals
        } else {
            return favoriteMeals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }
}
