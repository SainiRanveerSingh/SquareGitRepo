//
//  RepoListTableViewCell.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import UIKit

class RepoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBackgroundMain: UIView!
    @IBOutlet weak var imageViewRepoIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewInfoIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialSetup() {
        viewBackgroundMain.clipsToBounds = true
        viewBackgroundMain.layer.cornerRadius = 20.0
        viewBackgroundMain.layer.borderColor = UIColor.lightGray.cgColor
        viewBackgroundMain.layer.borderWidth = 0.5
        
        viewBackgroundMain.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(10.0))
        viewBackgroundMain.layer.shadowColor = UIColor.gray.cgColor
        viewBackgroundMain.layer.shadowRadius = 3
        viewBackgroundMain.layer.shadowOpacity = 0.25
        viewBackgroundMain.layer.masksToBounds = false;
        viewBackgroundMain.clipsToBounds = false;
    }
    
    func configureCell(indexPath: IndexPath, repoData: SquareGitRepoResponseElement?) {
        if repoData != nil {
            labelTitle.text = (repoData?.name ?? "").capitalized
            labelDescription.text = (repoData?.description ?? "").capitalized
            if repoData?.description == "" || repoData?.description == nil {
                labelDescription.text = "Description is not added for this Repo."
            }
        }
    }
}

