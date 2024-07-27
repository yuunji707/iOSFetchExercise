//
//  RandomMealViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

class RandomMealViewModel: ObservableObject {
    @Published var randomMealId: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    
    init() {
        fetchRandomMeal()
    }
    
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
