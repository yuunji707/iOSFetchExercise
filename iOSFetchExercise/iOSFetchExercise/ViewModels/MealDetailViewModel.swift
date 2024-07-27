//
//  MealDetailViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//


import SwiftUI

// MARK: - MealDetailViewModel

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetailModel?
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    
    func fetchMealDetail(id: String) async {
        do {
            let fetchedMealDetail = try await apiService.fetchMealDetail(id: id)
            DispatchQueue.main.async {
                self.mealDetail = fetchedMealDetail
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
