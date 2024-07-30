//
//  MealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// A view displaying a grid of dessert meals with search functionality
struct MealView: View {
    @StateObject private var viewModel = MealsViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack {
                SearchBar(text: $searchText)
                    .padding()
                
                MealGridView(meals: viewModel.filteredMeals(searchText: searchText))
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

/// A grid view of meals
struct MealGridView: View {
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

/// A custom search bar view
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search desserts...", text: $text)
                .padding(10)
                .padding(.horizontal, 30)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 12)
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
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

// Preview provider for MealView
struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealView()
        }
    }
}
