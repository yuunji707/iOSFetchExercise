//
//  APIService.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import Foundation

// MARK: - APIService

/// Service class for handling API requests
class APIService {
    /// Shared instance for singleton access
    static let shared = APIService()
    
    /// Private initializer to ensure singleton usage
    init() {}
    
    /// URLSession instance for making network requests
    var urlSession: URLSessionProtocol = URLSession.shared
    
    /// Fetches a list of dessert meals from the API
    /// - Returns: An array of MealModel objects, sorted alphabetically by name
    func fetchMeals() async throws -> [MealModel] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        return response.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    /// Fetches detailed information for a specific meal
    /// - Parameter id: The ID of the meal to fetch details for
    /// - Returns: A MealDetailModel object, or nil if not found
    func fetchMealDetail(id: String) async throws -> MealDetailModel? {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let (data, _) = try await urlSession.data(from: url)
        
        // First, decode into a dictionary
        let json = try JSONDecoder().decode([String: [MealDetailModel]?].self, from: data)
        
        // Check if 'meals' key exists and is not null
        if let meals = json["meals"], let firstMeal = meals?.first {
            return firstMeal
        } else {
            return nil
        }
    }
    
    /// Fetches a random meal ID from the API
    /// - Returns: A String representing the random meal ID, or nil if not found
    func fetchRandomMealID() async throws -> String? {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return response.meals.first?.idMeal
    }
}

// MARK: - URLSessionProtocol

/// Protocol to abstract URLSession for easier testing
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

/// Extension to make URLSession conform to URLSessionProtocol
extension URLSession: URLSessionProtocol {}
