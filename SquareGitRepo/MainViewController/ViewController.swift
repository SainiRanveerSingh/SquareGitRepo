//
//  ViewController.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewControllerViewModel()
    @IBOutlet weak var tableViewRepoList: RepoListTableView!
    
    //Pull to Refresh Code
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSetup()
    }
    
    func intialSetup() {
        viewModel.setupNavigationBarFor(viewController: self)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableViewRepoList.addSubview(refreshControl)
        tableViewRepoList.configure(viewModel)
        LoadingView.sharedInstance.showLoader(msg: "Loading...")
        callAPIToLoadRepoList()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh
        callAPIToLoadRepoList()
    }
    
    func callAPIToLoadRepoList() {
        viewModel.getSquareGitRepo { [weak self] status, message in
            guard let self = self else { return }
            DispatchQueue.main.async {
                LoadingView.sharedInstance.stopLoader()
                if status {
                    self.tableViewRepoList.displayData()
                    self.refreshControl.endRefreshing()
                } else {
                    //Error
                    LoadingView.sharedInstance.showError(msg: message)
                }
            }
        }
    }
    
}

