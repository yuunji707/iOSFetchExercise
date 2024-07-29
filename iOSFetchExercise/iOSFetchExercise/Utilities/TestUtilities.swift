//
//  TestUtilities.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/29/24.
//

import Foundation

class TestUtilities {
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

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (data ?? Data(), response)
    }
}

extension TestUtilities {
    static func mockSuccessfulURLSession(with data: Data) -> MockURLSession {
        let session = MockURLSession()
        session.data = data
        return session
    }
    
    static func mockFailingURLSession(with error: Error) -> MockURLSession {
        let session = MockURLSession()
        session.error = error
        return session
    }
}
