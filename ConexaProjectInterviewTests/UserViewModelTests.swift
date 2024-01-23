//
//  UserViewModelTests.swift
//  ConexaProjectInterviewTests
//
//  Created by Juan Bazan Carrizo on 02/01/2024.
//

import XCTest
@testable import ConexaProjectInterview

final class UserViewModelTests: XCTestCase {

    func testFetchPosts() {
        // Arrange
        let mockHttpClient = MockHttpClient(fileData: "UserData")
        let viewModel = UserViewModel(httpClient: mockHttpClient)
        let expectation = XCTestExpectation(description: "Users did update")
        viewModel.usersDidUpdate = {
            expectation.fulfill()
        }
        
        XCTAssertTrue(viewModel.users.isEmpty, "La lista de users debería estar vacía antes de una llamada exitosa a fetchUsers")
        
        // Act
        Task {
            await viewModel.fetchUsers()
        }
        
        // Wait for posts to update
        wait(for: [expectation], timeout: 10)
        
        // Assert
        XCTAssertTrue(mockHttpClient.fetchCalled)
        XCTAssertEqual(mockHttpClient.fetchURL, URL(string: Constants.baseURL + Endpoints.users))
        XCTAssertFalse(viewModel.users.isEmpty, "La lista de users no debería estar vacía después de una llamada exitosa a fetchUsers")
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users[0].firstname, "John")
        XCTAssertEqual(viewModel.users[0].lastname, "Doe")
        XCTAssertEqual(viewModel.users[0].address.street, "123 Main Street")
        XCTAssertEqual(viewModel.users[0].address.suite, "Apt. 4")
        XCTAssertEqual(viewModel.users[0].address.geo.lat, "42.1234")
        XCTAssertEqual(viewModel.users[0].address.geo.lng, "-71.2345")
    }
    
}
