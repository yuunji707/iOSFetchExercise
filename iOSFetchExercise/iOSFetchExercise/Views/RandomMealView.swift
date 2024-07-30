//
//  RandomMealView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import SwiftUI

/// A view that displays a random meal and allows users to fetch new random meals
struct RandomMealView: View {
    @StateObject private var viewModel = RandomMealViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                LoadingView()
            } else if let mealId = viewModel.randomMealId {
                RandomMealContentView(mealId: mealId)
            }
            
            RandomMealButton(action: viewModel.fetchRandomMeal, isDisabled: viewModel.isLoading)
        }
        .navigationTitle("Random Meal")
        .alert(item: Binding(
            get: { viewModel.errorMessage.map { ErrorWrapper(error: $0) } },
            set: { _ in viewModel.errorMessage = nil }
        )) { errorWrapper in
            Alert(
                title: Text("Error"),
                message: Text(errorWrapper.error),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

/// A view displaying a loading indicator
struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

/// A view displaying the content of a random meal
struct RandomMealContentView: View {
    let mealId: String
    
    var body: some View {
        ScrollView {
            MealDetailView(mealId: mealId)
        }
    }
}

/// A button for fetching a new random meal
struct RandomMealButton: View {
    let action: () -> Void
    let isDisabled: Bool
    
    var body: some View {
        Button(action: action) {
            Text("Get Random Meal")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(isDisabled)
        .padding()
    }
}

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: String
}

struct RandomMealView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RandomMealView()
        }
    }
}
