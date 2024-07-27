//
//  RandomMealViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// ViewModel for managing random meal selection
class RandomMealViewModel: ObservableObject {
    /// Published property to store the ID of the randomly selected meal
    @Published var randomMealId: String?
    /// Published property to track loading state
    @Published var isLoading = false
    /// Published property to store and update error messages
    @Published var errorMessage: String?
    
    /// Instance of APIService to fetch random meal
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
                    throw NSError(domain: "RandomMealViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch random meal ID"])
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
