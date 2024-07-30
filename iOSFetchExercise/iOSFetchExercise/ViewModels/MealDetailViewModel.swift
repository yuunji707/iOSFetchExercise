//
//  MealDetailViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// ViewModel for managing meal details
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetailModel?
    @Published var errorMessage: String?
    @Published var isFavorite: Bool = false
    
    private let apiService = APIService.shared
    private let favoritesManager = FavoritesManager.shared
    
    /// Fetches meal detail for a given meal ID
    /// - Parameter id: The ID of the meal to fetch details for
    func fetchMealDetail(id: String) async {
        do {
            let fetchedMealDetail = try await apiService.fetchMealDetail(id: id)
            DispatchQueue.main.async {
                if let fetchedMealDetail = fetchedMealDetail {
                    self.mealDetail = fetchedMealDetail
                    self.checkFavoriteStatus()
                } else {
                    self.errorMessage = "Meal not found"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch meal details: \(error.localizedDescription)"
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
