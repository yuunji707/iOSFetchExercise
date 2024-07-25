# iOS Dessert Recipe App

This iOS app allows users to browse dessert recipes using the [TheMealDB API](https://themealdb.com/api.php). Users can view a list of desserts and tap on any dessert to see its detailed recipe.

## Features

- Display a list of dessert meals sorted alphabetically
- View detailed information for each dessert, including:
  - Meal name
  - Instructions
  - Ingredients with measurements
- Asynchronous image loading
- Error handling with user-friendly alerts

## Architecture

This project follows the MVVM (Model-View-ViewModel) architecture pattern and is built using SwiftUI.

### Project Structure

- `ContentView.swift`: The main view of the application
- `MealView.swift`: Displays the list of dessert meals
- `MealDetailView.swift`: Shows detailed information about a selected meal
- `MealModel.swift`: Defines the data model for a meal
- `MealDetailModel.swift`: Defines the data model for detailed meal information
- `MealsViewModel.swift`: Manages the data and business logic for the meal list
- `MealDetailViewModel.swift`: Manages the data and business logic for the meal details

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone this repository
2. Open the project in Xcode
3. Build and run the project on your simulator or device

## API Endpoints

The app uses the following API endpoints:

- Dessert list: `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`
- Meal details: `https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID`

## Implementation Details

- Uses Swift Concurrency (async/await) for asynchronous operations
- Implements error handling and displays user-friendly error messages
- Filters out null or empty values from the API response
- Uses SwiftUI for the user interface
