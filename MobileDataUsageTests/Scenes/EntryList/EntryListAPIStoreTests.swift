//
//  EntryListAPIStore.swift
//  MobileDataUsageTests
//
//  Created by Jasper Alain Goce on 27/3/20.
//

import XCTest
@testable import MobileDataUsage

class EntryListAPIStoreTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            try super.setUpWithError()
            sut = URLSession(configuration: .default)
        } catch {
            XCTFail("Failed to setup: \(error)")
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        do {
            sut = nil
            try super.setUpWithError()
        } catch {
            XCTFail("Failed to teardown: \(error)")
        }
    }
    
    // MARK: Tests
    
    func testCallToDataGovSG() {
        // Given
        var urlComponent = URLComponents(string: Constant.dataURL)
        urlComponent?.queryItems = [
            URLQueryItem(name: "resource_id", value: Constant.resourceID)
        ]
        let url = urlComponent?.url
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // When
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
}
