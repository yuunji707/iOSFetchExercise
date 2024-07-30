//
//  TestUtilities.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/29/24.
//

import Foundation

struct TestUtilities {
    // MARK: - Model Creation

    static func createMealDetailModel(id: String, name: String) -> MealDetailModel {
        let json = """
        {
            "idMeal": "\(id)",
            "strMeal": "\(name)",
            "strInstructions": "Test Instructions",
            "strMealThumb": "https://example.com/thumb.jpg",
            "strIngredient1": "Ingredient1",
            "strMeasure1": "Measure1"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        return try! decoder.decode(MealDetailModel.self, from: json)
    }
}

// MARK: - MockAPIService

class MockAPIService: APIService {
    static let mockShared = MockAPIService()
    
    var mockMeals: [MealModel] = []
    var mockMealDetail: MealDetailModel?
    var mockRandomMealID: String?
    var shouldFail = false

    override private init() {
        super.init()
    }

    static func resetMockShared() {
        // Reset the properties of the existing mockShared instance
        mockShared.mockMeals = []
        mockShared.mockMealDetail = nil
        mockShared.mockRandomMealID = nil
        mockShared.shouldFail = false
    }

    override func fetchMeals() async throws -> [MealModel] {
        if shouldFail {
            throw NSError(domain: "MockAPIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return mockMeals
    }

    override func fetchMealDetail(id: String) async throws -> MealDetailModel? {
        if shouldFail {
            throw NSError(domain: "MockAPIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return mockMealDetail
    }

    override func fetchRandomMealID() async throws -> String? {
        if shouldFail {
            throw NSError(domain: "MockAPIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return mockRandomMealID
    }
}
