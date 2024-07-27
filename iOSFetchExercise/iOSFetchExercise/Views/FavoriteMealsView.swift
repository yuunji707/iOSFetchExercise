//
//  FavoriteMealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

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
                    VStack {
                        Spacer()
                        Text("You haven't added any favorites yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
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
            viewModel.loadFavorites()
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
