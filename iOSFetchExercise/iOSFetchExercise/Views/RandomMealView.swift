//
//  RandomMealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

struct RandomMealView: View {
    @StateObject private var viewModel = RandomMealViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
            } else if let mealId = viewModel.randomMealId {
                ScrollView {
                    MealDetailView(mealId: mealId)
                }
            }
            
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
        .alert("Error", isPresented: Binding.constant(viewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
            }
        }, message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        })
    }
}

struct RandomMealView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RandomMealView()
        }
    }
}
