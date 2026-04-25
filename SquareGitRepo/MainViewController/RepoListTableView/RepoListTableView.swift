//
//  RepoListTableView.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation
import UIKit

class RepoListTableView: UITableView {
    
    var mainViewControllerViewModel: ViewControllerViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ viewModel: ViewControllerViewModel) {
        self.mainViewControllerViewModel = viewModel
        dataSource = self
        delegate = self
        let nib = UINib.init(nibName: "RepoListTableViewCell", bundle: nil)
        self.register(nib, forCellReuseIdentifier: "RepoListTableViewCell")
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.estimatedRowHeight = 350.0
        if self.tableFooterView != nil {
            self.tableFooterView = UIView()
        }
    }
    
}

extension RepoListTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewControllerViewModel.arrayRepoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(indexPath : indexPath)
    }
    
    func cell(indexPath : IndexPath) -> RepoListTableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "RepoListTableViewCell", for: indexPath) as! RepoListTableViewCell
        let repoValue = self.mainViewControllerViewModel.arrayRepoList[indexPath.row]
        cell.configureCell(indexPath: indexPath, repoData: repoValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        
        //didSelect?(self.viewModel.arrayMyCoursesList[indexPath.row], indexPath.row, .simple, bgColor)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func displayData() {
        self.reloadData()
    }
    
    
}
