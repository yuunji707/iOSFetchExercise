//
//  RandomMealViewModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/28/24.
//

/*
import XCTest
@testable import iOSFetchExercise

class RandomMealViewModelTests: XCTestCase {
    var viewModel: RandomMealViewModel!
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = RandomMealViewModel(apiService: mockAPIService)
    }

    func testFetchRandomMealSuccess() async {
        mockAPIService.mockRandomMealID = "123"

        await viewModel.fetchRandomMeal()

        XCTAssertEqual(viewModel.randomMealId, "123")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchRandomMealFailure() async {
        mockAPIService.shouldFail = true

        await viewModel.fetchRandomMeal()

        XCTAssertNil(viewModel.randomMealId)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

class MockAPIService: APIService {
    var mockRandomMealID: String?
    var shouldFail = false

    override func fetchRandomMealID() async throws -> String? {
        if shouldFail {
            throw NSError(domain: "MockAPIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return mockRandomMealID
    }
}

*/
