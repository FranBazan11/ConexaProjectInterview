//
//  HttpClientTests.swift
//  ConexaProjectInterviewTests
//
//  Created by Juan Bazan Carrizo on 29/12/2023.
//

import XCTest
@testable import ConexaProjectInterview

final class HttpClientTests: XCTestCase {
    func testFetchSuccess() async throws {
        // Arrange
        let mockData = try JSONSerialization.data(withJSONObject: ["franData"])
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let mockSession = MockURLSession()
        mockSession.dataResult = (mockData, mockResponse)
        let httpClient = HttpClient.configureSharedInstance(urlSession: mockSession)

        // Act
        let result: [String] = try await httpClient.fetch(url: URL(string: "https://example.com"))

        // Assert
        XCTAssertEqual(result, ["franData"])
    }

    func testFetchBadURL() async {
        // Arrange - Act - Assert
        do {
            let _ : [PostModel] = try await HttpClient.shared.fetch(url: nil)
            XCTFail("Expected an error to be thrown.")
        } catch {
            XCTAssertTrue(error is HttpError)
            XCTAssertEqual(error as? HttpError, HttpError.badURL)
        }
    }

    func testFetchBadResponse() async {
        do {
            // Arrange
            let mockSession = MockURLSession()
            let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 500, httpVersion: "HTTP/1.1", headerFields: nil)!
            mockSession.dataResult = (Data(), mockResponse)
            let httpClient = HttpClient.configureSharedInstance(urlSession: mockSession)
            let _ : [PostModel] = try await httpClient.fetch(url: URL(string: "https://example.com"))

            // Act - Assert
            XCTFail("Expected an error to be thrown.")
        } catch {
            XCTAssertTrue(error is HttpError)
            XCTAssertEqual(error as? HttpError, HttpError.badResponse)
        }
    }

    func testFetchErrorDecodingData() async {
        // Arrange
        let mockSession = MockURLSession()
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        mockSession.dataResult = (Data(), mockResponse)
        let httpClient = HttpClient.configureSharedInstance(urlSession: mockSession)

        // Act & Assert
        do {
            let _ : [PostModel] = try await httpClient.fetch(url: URL(string: "https://example.com"))
            XCTFail("Expected an error to be thrown.")
        } catch {
            XCTAssertTrue(error is HttpError)
            XCTAssertEqual(error as? HttpError, HttpError.errorDecodingData)
        }
    }
}
