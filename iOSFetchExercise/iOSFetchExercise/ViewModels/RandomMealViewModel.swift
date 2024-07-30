//
//  RandomMealViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// ViewModel for managing random meal selection
class RandomMealViewModel: ObservableObject {
    @Published var randomMealId: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    
    /// Initializes the ViewModel and fetches a random meal
    init() {
        fetchRandomMeal()
    }
    
    /// Fetches a random meal ID from the API
    func fetchRandomMeal() {
        isLoading = true
        randomMealId = nil
        errorMessage = nil
        
        Task {
            do {
                if let randomMealID = try await apiService.fetchRandomMealID() {
                    DispatchQueue.main.async {
                        self.randomMealId = randomMealID
                        self.isLoading = false
                    }
                } else {
                    throw NSError(domain: "RandomMealViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No random meal found"])
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch random meal: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
