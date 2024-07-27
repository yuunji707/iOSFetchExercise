//
//  RandomMealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// A view that displays a random meal and allows users to fetch new random meals
struct RandomMealView: View {
    @StateObject private var viewModel = RandomMealViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                // Show loading indicator while fetching meal
                ProgressView()
            } else if let mealId = viewModel.randomMealId {
                // Display meal details if a random meal has been fetched
                ScrollView {
                    MealDetailView(mealId: mealId)
                }
            }
            
            // Button to fetch a new random meal
            Button(action: { viewModel.fetchRandomMeal() }) {
                Text("Get Random Meal")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .disabled(viewModel.isLoading)
        }
        .navigationTitle("Random Meal")
        // Display an alert if there's an error
        .alert("Error", isPresented: Binding.constant(viewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
            }
        }, message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        })
    }
}

// Preview provider for RandomMealView
struct RandomMealView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RandomMealView()
        }
    }
}
