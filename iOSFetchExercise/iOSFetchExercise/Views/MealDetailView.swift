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
                // Display meal image
                MealImageView(imageURL: viewModel.mealDetail?.strMealThumb)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Display meal name and favorite button
                    MealHeaderView(mealName: viewModel.mealDetail?.strMeal ?? "",
                                   isFavorite: viewModel.isFavorite,
                                   toggleFavorite: viewModel.toggleFavorite)
                    
                    // Display meal area if available
                    if let area = viewModel.mealDetail?.strArea {
                        Label(area, systemImage: "mappin.circle.fill")
                            .font(.headline)
                    }
                    
                    // Display meal tags
                    TagsView(tags: viewModel.mealDetail?.tagsArray ?? [])
                    
                    // Display YouTube link if available
                    LinkView(title: "Watch on YouTube",
                             url: viewModel.mealDetail?.strYoutube,
                             icon: "play.circle.fill",
                             color: .red)
                    
                    // Display source link if available
                    LinkView(title: "View Recipe Source",
                             url: viewModel.mealDetail?.strSource,
                             icon: "link.circle.fill",
                             color: .blue)
                    
                    // Display cooking instructions
                    InstructionsView(instructions: viewModel.mealDetail?.strInstructions ?? "")
                    
                    // Display ingredients and measurements
                    IngredientsView(ingredients: viewModel.mealDetail?.ingredientsWithMeasurements ?? [])
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

/// A view for displaying the meal image
struct MealImageView: View {
    let imageURL: String?
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

/// A view for displaying the meal name and favorite button
struct MealHeaderView: View {
    let mealName: String
    let isFavorite: Bool
    let toggleFavorite: () -> Void
    
    var body: some View {
        HStack {
            Text(mealName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
                    .font(.title)
            }
        }
    }
}

/// A view for displaying meal tags
struct TagsView: View {
    let tags: [String]
    
    var body: some View {
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
}

/// A view for displaying links (YouTube or source)
struct LinkView: View {
    let title: String
    let url: String?
    let icon: String
    let color: Color
    
    var body: some View {
        if let url = url, let linkURL = URL(string: url) {
            Link(destination: linkURL) {
                Label(title, systemImage: icon)
            }
            .font(.headline)
            .foregroundColor(color)
        }
    }
}

/// A view for displaying cooking instructions
struct InstructionsView: View {
    let instructions: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Instructions")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(instructions)
                .font(.body)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
    }
}

/// A view for displaying ingredients and measurements
struct IngredientsView: View {
    let ingredients: [(String, String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(ingredients, id: \.0) { ingredient, measurement in
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
}

// Preview provider for MealDetailView
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(mealId: "52893") // Example meal ID
        }
    }
}
