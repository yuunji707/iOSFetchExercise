//
//  MockURLSession.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import Foundation


// Mock URLSession for testing network requests
class MockURLSession: URLSessionProtocol {
    var dataToReturn: Data?
    var errorToThrow: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = errorToThrow {
            throw error
        }
        return (dataToReturn ?? Data(), URLResponse())
    }
    
    func setDataToReturn(_ data: Data?) {
        self.dataToReturn = data
    }
    
    func setErrorToThrow(_ error: Error?) {
        self.errorToThrow = error
    }
}
