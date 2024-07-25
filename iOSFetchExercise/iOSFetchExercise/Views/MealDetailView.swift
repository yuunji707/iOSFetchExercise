//
//  MealDetailView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Meal Image
                AsyncImage(url: URL(string: viewModel.mealDetail?.strMealThumb ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(12)
                
                // Meal Name
                Text(viewModel.mealDetail?.strMeal ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Area
                if let area = viewModel.mealDetail?.strArea {
                    Text("Area: \(area)")
                        .font(.subheadline)
                }
                
                // Tags
                if let tags = viewModel.mealDetail?.tagsArray, !tags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(5)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                
                // YouTube Link
                if let youtubeURL = viewModel.mealDetail?.strYoutube, let url = URL(string: youtubeURL) {
                    Link("Watch on YouTube", destination: url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                // Source Link
                if let sourceURL = viewModel.mealDetail?.strSource, let url = URL(string: sourceURL) {
                    Link("View Recipe Source", destination: url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                // Instructions
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(viewModel.mealDetail?.strInstructions ?? "")
                        .font(.body)
                }
                
                // Ingredients
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(viewModel.mealDetail?.ingredientsWithMeasurements ?? [], id: \.0) { ingredient, measurement in
                        Text("• \(measurement) \(ingredient)")
                            .font(.body)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Meal Detail")
        .task {
            await viewModel.fetchMealDetail(id: mealId)
        }
        .alert("Error", isPresented: Binding.constant(viewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        })
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(mealId: "52893") // Example meal ID
        }
    }
}
