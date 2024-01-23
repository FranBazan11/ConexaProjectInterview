//
//  PostViewModelTests.swift
//  ConexaProjectInterviewTests
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//


import XCTest
@testable import ConexaProjectInterview


class PostViewModelTests: XCTestCase {
    func testFetchPosts() {
            // Arrange
        let mockHttpClient = MockHttpClient(fileData: "PostData")
            let viewModel = PostViewModel(httpClient: mockHttpClient)
            let expectation = XCTestExpectation(description: "Posts did update")
            viewModel.postsDidUpdate = {
                expectation.fulfill()
            }
            
            XCTAssertTrue(viewModel.posts.isEmpty, "La lista de posts debería estar vacía antes de una llamada exitosa a fetchPosts")
        
            // Act
            Task {
                await viewModel.fetchPosts()
            }
            
            // Wait for posts to update
            wait(for: [expectation], timeout: 10)
            
            // Assert
            XCTAssertTrue(mockHttpClient.fetchCalled)
            XCTAssertEqual(mockHttpClient.fetchURL, URL(string: Constants.baseURL + Endpoints.posts))
            XCTAssertFalse(viewModel.posts.isEmpty, "La lista de posts no debería estar vacía después de una llamada exitosa a fetchPosts")
            XCTAssertEqual(viewModel.posts.count, 1)
            XCTAssertEqual(viewModel.posts[0].title, "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
        }
}

// MARK: - Mocks

class MockHttpClient: HttpClientProtocol {
    var fetchCalled = false
    var fetchURL: URL?
    let fileData: String
    
    init(fetchCalled: Bool = false, fetchURL: URL? = nil, fileData: String) {
        self.fetchCalled = fetchCalled
        self.fetchURL = fetchURL
        self.fileData = fileData
    }
    
    func fetch<T: Codable>(url: URL?) async throws -> [T] {
        fetchCalled = true
        fetchURL = url
        
        let mockData: Data = {
            guard let data = loadJSONData(from: fileData) else {
                fatalError("No se pudo cargar el archivo JSON.")
            }
            return data
        }()
        
        guard let object = try? JSONDecoder().decode([T].self, from: mockData) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
    
    func loadJSONData(from filename: String) -> Data? {
        if let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Error al cargar datos JSON: \(error)")
            }
        }
        return nil
    }
}
