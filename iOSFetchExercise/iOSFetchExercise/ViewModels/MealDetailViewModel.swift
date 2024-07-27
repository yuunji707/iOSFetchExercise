//
//  MealDetailViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//


import SwiftUI

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetailModel?
    @Published var errorMessage: String?
    @Published var isFavorite: Bool = false
    
    private let apiService = APIService.shared
    private let favoritesManager = FavoritesManager.shared
    
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
    
    func checkFavoriteStatus() {
        guard let meal = mealDetail else { return }
        isFavorite = favoritesManager.isFavorite(meal: meal)
    }
    
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
