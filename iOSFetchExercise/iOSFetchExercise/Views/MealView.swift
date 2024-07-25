
//
//  MealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// A view displaying a grid of dessert meals
struct MealView: View {
    @StateObject private var viewModel = MealsViewModel()
    
    var body: some View {
        ZStack {
            // Set the background color
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                // Create a grid layout for meal cards
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.meals) { meal in
                        // Navigate to meal detail view when tapped
                        NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                            MealCard(meal: meal)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Desserts")
        // Fetch meals when the view appears
        .task {
            await viewModel.fetchMeals()
        }
        // Display an alert if there's an error
        .alert("Error", isPresented: Binding.constant(viewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        })
    }
}

/// A card view representing a single meal
struct MealCard: View {
    let meal: MealModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Asynchronously load and display the meal image
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            // Display the meal name
            Text(meal.strMeal)
                .font(.headline)
                .lineLimit(2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealView()
        }
    }
}
