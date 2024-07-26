//
//  URLSessionProtocol.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
extension URLSession: URLSessionProtocol { }



