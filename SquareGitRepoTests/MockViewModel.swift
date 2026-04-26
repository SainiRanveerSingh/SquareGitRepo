//
//  MockViewModel.swift
//  SquareGitRepoTests
//
//  Created by RV on 26/04/26.
//

import Foundation
class MockViewModel: ViewControllerViewModelProtocol {
    
    var arrayRepoList = SquareGitRepoResponse()
    var shouldReturnSuccess = true
    
    func getSquareGitRepo(completion: @escaping (Bool, String) -> Void) {
        if shouldReturnSuccess {
            completion(true, "Success")
        } else {
            completion(false, "Error")
        }
    }
}
