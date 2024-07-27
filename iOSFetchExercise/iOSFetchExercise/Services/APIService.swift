//
//  APIService.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/26/24.
//

import Foundation

// MARK: - APIService

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    var urlSession: URLSessionProtocol = URLSession.shared
    
    func fetchMeals() async throws -> [MealModel] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        return response.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetailModel? {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return response.meals.first
    }
    
    func fetchRandomMealID() async throws -> String? {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        let (data, _) = try await urlSession.data(from: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return response.meals.first?.idMeal
    }
}

// MARK: - URLSessionProtocol

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
