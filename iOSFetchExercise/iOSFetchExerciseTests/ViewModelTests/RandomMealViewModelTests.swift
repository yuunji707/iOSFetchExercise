//
//  RandomMealViewModelTests.swift
//  iOSFetchExerciseTests
//
//  Created by Younis on 7/28/24.
//
import XCTest
@testable import iOSFetchExercise

class RandomMealViewModelTests: XCTestCase {
    var viewModel: RandomMealViewModel!

    override func setUp() {
        super.setUp()
        MockAPIService.resetMockShared()
        viewModel = RandomMealViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchRandomMeal_Success() async {
        // This test should:
        // 1. Set up the MockAPIService to return a successful result (a valid meal ID)
        // 2. Call viewModel.fetchRandomMeal()
        // 3. Assert that:
        //    - viewModel.randomMealId is set to the expected meal ID
        //    - viewModel.isLoading is false
        //    - viewModel.errorMessage is nil
    }

    func testFetchRandomMeal_Failure() async {
        // This test should:
        // 1. Set up the MockAPIService to simulate a failure (throw an error)
        // 2. Call viewModel.fetchRandomMeal()
        // 3. Assert that:
        //    - viewModel.randomMealId is nil
        //    - viewModel.isLoading is false
        //    - viewModel.errorMessage is not nil and contains an error message
    }

    func testFetchRandomMeal_NoMealIDReturned() async {
        // This test should:
        // 1. Set up the MockAPIService to return nil (simulating no meal ID found)
        // 2. Call viewModel.fetchRandomMeal()
        // 3. Assert that:
        //    - viewModel.randomMealId is nil
        //    - viewModel.isLoading is false
        //    - viewModel.errorMessage is not nil and contains an appropriate message
        
    }

    func testInitialState() {
        // This test should:
        // 1. Create a new instance of RandomMealViewModel
        // 2. Immediately assert that:
        //    - viewModel.isLoading is true (assuming fetchRandomMeal is called in init)
        //    - viewModel.randomMealId is nil
        //    - viewModel.errorMessage is nil
        // Note: This test checks the initial state before any async operations complete
    }
}
