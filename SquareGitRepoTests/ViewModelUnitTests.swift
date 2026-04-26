//
//  ViewModelUnitTests.swift
//  SquareGitRepoTests
//
//  Created by RV on 26/04/26.
//

import XCTest
@testable import SquareGitRepo

final class ViewModelUnitTests: XCTestCase {
    
    var viewModel: ViewControllerViewModel!
    var mockAPIManager: MockAPIManager!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        viewModel = ViewControllerViewModel(apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    //Success Case
    func testGetRepoListSuccess() {
        
        let jsonString = """
            [
                {
                    "id": 1,
                    "name": "Test Repo"
                }
            ]
            """
        
        mockAPIManager.mockData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "API Success")
        
        viewModel.getSquareGitRepo { status, message in
            XCTAssertTrue(status)
            XCTAssertEqual(self.viewModel.arrayRepoList.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
    
    //Failure Case - API Error
    func testGetRepoListFailure() {
        
        mockAPIManager.shouldReturnError = true
        mockAPIManager.mockError = "No Internet"
        
        let expectation = self.expectation(description: "API Failure")
        
        viewModel.getSquareGitRepo { status, message in
            XCTAssertFalse(status)
            XCTAssertEqual(message, "No Internet")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
    
    //Failure Case - Invalid JSON
    func testGetRepoListDecodingFailure() {
        
        let invalidJSON = "{ invalid json }"
        mockAPIManager.mockData = invalidJSON.data(using: .utf8)
        
        let expectation = self.expectation(description: "Decoding Failure")
        
        viewModel.getSquareGitRepo { status, message in
            XCTAssertFalse(status)
            XCTAssertFalse(self.viewModel.arrayRepoList.count > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
}
