//
//  FavoriteMealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// A view displaying the user's favorite meals
struct FavoriteMealsView: View {
    @StateObject private var viewModel = FavoriteMealsViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack {
                SearchBar(text: $searchText)
                    .padding()
                
                if viewModel.filteredMeals(searchText: searchText).isEmpty {
                    EmptyFavoritesView()
                } else {
                    FavoriteMealsGridView(meals: viewModel.filteredMeals(searchText: searchText))
                }
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

/// A view displayed when there are no favorites
struct EmptyFavoritesView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("You haven't added any favorites yet")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

/// A grid view of favorite meals
struct FavoriteMealsGridView: View {
    let meals: [MealModel]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(meals) { meal in
                    NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                        MealCard(meal: meal)
                    }
                }
            }
            .padding()
        }
    }
}

struct FavoriteMealsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoriteMealsView()
        }
    }
}
