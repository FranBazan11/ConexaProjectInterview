//
//  URLSessionExtension.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//

import Foundation

// MARK: - URLSession
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}


// MARK: - Mock URLSession
class MockURLSession: URLSessionProtocol {
    
    var dataResult: (Data, URLResponse)!
    var errorResult: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = errorResult {
            throw error
        }
        return dataResult
    }
}
