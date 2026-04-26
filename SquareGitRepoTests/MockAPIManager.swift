//
//  MockAPIManager.swift
//  SquareGitRepoTests
//
//  Created by RV on 26/04/26.
//

import Foundation
class MockAPIManager: APIManaging {
    
    var shouldReturnError = false
    var mockData: Data?
    var mockError: String?
    
    func post(params: [String : Any], url: String, accessTokenValue: String, completionHandler: @escaping (Data?, String?) -> Void) {
        // Not needed for now
    }
    
    func get(params: [String : String], url: String, accessTokenValue: String, completionHandler: @escaping (Data?, String?) -> Void) {
        
        if shouldReturnError {
            completionHandler(nil, mockError ?? "Mock Error")
        } else {
            completionHandler(mockData, nil)
        }
    }
}
