//
//  MealDetailViewModel.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//


import SwiftUI

// MARK: - MealDetailViewModel

/// ViewModel for handling the detailed information of a specific meal
class MealDetailViewModel: ObservableObject {
    // Published properties to update the UI when changed
    @Published var mealDetail: MealDetailModel?
    @Published var errorMessage: String?
    
    //might remove
    var urlSession: URLSessionProtocol = URLSession.shared
    
    /// Fetches detailed information for a specific meal
    /// - Parameter id: The ID of the meal to fetch
    func fetchMealDetail(id: String) async {
        do {
            // Construct the URL for the API request
            let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
            
            // Perform the network request
            let (data, _) = try await urlSession.data(from: url)
            
            // Decode the response data
            let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.mealDetail = response.meals.first
            }
        } catch {
            // Handle any errors and update the UI on the main thread
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
