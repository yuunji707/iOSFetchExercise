//
//  MealDetailViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// ViewModel for managing meal details
class MealDetailViewModel: ObservableObject {
    /// Published property to store and update meal details
    @Published var mealDetail: MealDetailModel?
    /// Published property to store and update error messages
    @Published var errorMessage: String?
    /// Published property to track favorite status of the meal
    @Published var isFavorite: Bool = false
    
    /// Instance of APIService to fetch meal details
    private let apiService = APIService.shared
    /// Instance of FavoritesManager to handle favorite meals
    private let favoritesManager = FavoritesManager.shared
    
    /// Fetches meal detail for a given meal ID
    /// - Parameter id: The ID of the meal to fetch details for
    func fetchMealDetail(id: String) async {
        do {
            let fetchedMealDetail = try await apiService.fetchMealDetail(id: id)
            DispatchQueue.main.async {
                self.mealDetail = fetchedMealDetail
                self.checkFavoriteStatus()
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    /// Checks if the current meal is a favorite
    func checkFavoriteStatus() {
        guard let meal = mealDetail else { return }
        isFavorite = favoritesManager.isFavorite(meal: meal)
    }
    
    /// Toggles the favorite status of the current meal
    func toggleFavorite() {
        guard let meal = mealDetail else { return }
        if isFavorite {
            favoritesManager.removeFavorite(meal: meal)
        } else {
            favoritesManager.addFavorite(meal: meal)
        }
        isFavorite.toggle()
    }
}
