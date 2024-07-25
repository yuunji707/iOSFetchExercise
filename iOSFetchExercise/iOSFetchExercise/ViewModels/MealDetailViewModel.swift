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
    
    func fetchMealDetail(id: String) async {
        do {
            let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            DispatchQueue.main.async {
                self.mealDetail = response.meals.first
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
