# iOS Fetch Exercise

## Overview

This iOS app allows users to browse dessert recipes using the MealDB API. Users can view a list of dessert meals, search for specific desserts, view detailed information about each meal, and save their favorite recipes.

## Features

- Browse a list of dessert meals sorted alphabetically
- Search functionality to filter desserts
- Detailed view for each meal, including:
  - Meal name
  - Instructions
  - Ingredients with measurements
  - Area of origin
  - Tags
  - YouTube link (if available)
  - Source link (if available)
- Favorite meals functionality
- Random meal generator

## Technologies Used

- Swift 5
- SwiftUI
- Swift Concurrency (async/await) for asynchronous operations
- MVVM (Model-View-ViewModel) architecture

## Requirements

- iOS 15.0+
- Xcode 13.0+

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/ios-fetch-exercise.git
   ```
2. Open the project in Xcode:
   ```
   cd ios-fetch-exercise
   open iOSFetchExercise.xcodeproj
   ```
3. Build and run the project in Xcode using a simulator or connected device.

## Project Structure

- `iOSFetchExerciseApp.swift`: Main app entry point
- `ContentView.swift`: Main container view with tab navigation
- `MealView.swift`: Displays the list of dessert meals
- `MealDetailView.swift`: Shows detailed information about a selected meal
- `RandomMealView.swift`: Generates and displays a random meal
- `FavoriteMealsView.swift`: Shows the user's favorite meals
- `APIService.swift`: Handles API requests to the MealDB
- `Models`: Contains data models for meals and API responses
- `ViewModels`: Contains view models for managing app state and business logic

## API Integration

This app uses the following endpoints from the MealDB API:

- `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`: Fetches the list of meals in the Dessert category
- `https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID`: Fetches meal details by ID
- `https://www.themealdb.com/api/json/v1/1/random.php`: Fetches a random meal

## Implementation Details

- Uses Swift Concurrency (async/await) for asynchronous operations
- Implements error handling and displays user-friendly error messages
- Filters out null or empty values from the API response
- Uses SwiftUI for the user interface
