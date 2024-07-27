//
//  MealDetailView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// A view displaying detailed information about a specific meal
struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Meal Image
                AsyncImage(url: URL(string: viewModel.mealDetail?.strMealThumb ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Meal Name and Favorite Button
                    HStack {
                        Text(viewModel.mealDetail?.strMeal ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite()
                        }) {
                            Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                                .foregroundColor(viewModel.isFavorite ? .yellow : .gray)
                                .font(.title)
                        }
                    }
                    
                    // Area
                    if let area = viewModel.mealDetail?.strArea {
                        Label(area, systemImage: "mappin.circle.fill")
                            .font(.headline)
                    }
                    
                    // Tags
                    if let tags = viewModel.mealDetail?.tagsArray, !tags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(tags, id: \.self) { tag in
                                    Text(tag)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }
                    
                    // YouTube Link
                    if let youtubeURL = viewModel.mealDetail?.strYoutube, let url = URL(string: youtubeURL) {
                        Link(destination: url) {
                            Label("Watch on YouTube", systemImage: "play.circle.fill")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                    }
                    
                    // Source Link
                    if let sourceURL = viewModel.mealDetail?.strSource, let url = URL(string: sourceURL) {
                        Link(destination: url) {
                            Label("View Recipe Source", systemImage: "link.circle.fill")
                        }
                        .font(.headline)
                        .foregroundColor(.blue)
                    }
                    
                    // Instructions
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(viewModel.mealDetail?.strInstructions ?? "")
                            .font(.body)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    
                    // Ingredients
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ForEach(viewModel.mealDetail?.ingredientsWithMeasurements ?? [], id: \.0) { ingredient, measurement in
                            HStack {
                                Text("•")
                                Text(measurement)
                                    .fontWeight(.semibold)
                                Text(ingredient)
                            }
                            .font(.body)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            // Fetch meal details when view appears
            await viewModel.fetchMealDetail(id: mealId)
            viewModel.checkFavoriteStatus()
        }
        .alert("Error", isPresented: Binding.constant(viewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        })
    }
}

// Preview provider for MealDetailView
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(mealId: "52893") // Example meal ID
        }
    }
}
