//
//  ViewControllerViewModel.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation
import UIKit
final class ViewControllerViewModel {
    
    private let apiManager: APIManaging
    
    init(apiManager: APIManaging = APIManager.sharedInstance) {
        self.apiManager = apiManager
    }
    
    var arrayRepoList = SquareGitRepoResponse()
    
    func setupNavigationBarFor(viewController: UIViewController) {
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.title = "Square Git Repo"
        viewController.navigationController?.navigationBar.isHidden = false
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        
    }
    
    func getSquareGitRepo(completion: @escaping (_ status: Bool, _ message: String) -> Void) {
        
        apiManager.get(params: ["":""], url: APPURL.Urls.Repos, accessTokenValue: "") { [weak self] responseData, error in            
            guard let self = self else { return }
            if error == nil {
                guard let data = responseData else {
                    completion(false, error ?? ErrorMessages.ServerError.responseErrorTryAgain)
                    return
                }
                do {                    
                    let model = try JSONDecoder().decode(SquareGitRepoResponse.self, from: data)
                    //print(model)
                    self.arrayRepoList = model
                    completion(true, "Success")
                    
                } catch {
                    //Either decoding error or JSONSerialization error.
                    print(error.localizedDescription)
                    completion(false, error.localizedDescription)
                }
            }  else {
                completion(false, error ?? ErrorMessages.ServerError.responseErrorTryAgain)
            }
        }
    }
    
}
