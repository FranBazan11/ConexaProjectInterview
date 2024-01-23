//
//  HttpClient.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 24/12/2023.
//

import Foundation


protocol HttpClientProtocol {
    func fetch<T: Codable>(url: URL?) async throws -> [T]
}

class HttpClient: HttpClientProtocol {
    // MARK: - SINGLETONS
    static var shared = HttpClient()
    
    // MARK: - PROPERTIES
    private let urlSession: URLSessionProtocol

    // MARK: - INIT
    private init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - CONFIGURE SHARED INSTANCE
    static func configureSharedInstance(urlSession: URLSessionProtocol) -> HttpClient {
        return HttpClient(urlSession: urlSession)
    }
    
    // MARK: - FUNCs
    func fetch<T: Codable>(url: URL?) async throws -> [T] {
        guard let url = url else {
            throw HttpError.badURL
        }
    
        let (data, response) = try await urlSession.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
}

// MARK: - ENUMs
enum HttpMethod: String {
    case GET, PUT, POST, DELETE
}

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}
