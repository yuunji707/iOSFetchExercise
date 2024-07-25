//
//  ContentView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.meals) { meal in
                            NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                                MealCard(meal: meal)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchMeals()
            }
            .alert("Error", isPresented: Binding.constant(viewModel.errorMessage != nil), actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            })
        }
    }
}

struct MealCard: View {
    let meal: MealModel
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
