//
//  FavoriteMealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// A view displaying the user's favorite meals
struct FavoriteMealsView: View {
    // ViewModel to manage favorite meals data
    @StateObject private var viewModel = FavoriteMealsViewModel()
    // State for search text input
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            // Set background color
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack {
                // Search bar for filtering meals
                SearchBar(text: $searchText)
                    .padding()
                
                // Display message if no favorites or filtered results
                if viewModel.filteredMeals(searchText: searchText).isEmpty {
                    VStack {
                        Spacer()
                        Text("You haven't added any favorites yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
                    // Scrollable grid of favorite meals
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.filteredMeals(searchText: searchText)) { meal in
                                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                                    MealCard(meal: meal)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            // Load favorites when view appears
            viewModel.loadFavorites()
        }
    }
}

// Preview provider for FavoriteMealsView
struct FavoriteMealsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoriteMealsView()
        }
    }
}
