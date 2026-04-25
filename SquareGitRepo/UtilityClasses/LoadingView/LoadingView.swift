//
//  LoadingView.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblmsg: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewError: UIImageView!
    
    static let sharedInstance = LoadingView.initLoader()
    
    class func initLoader() -> LoadingView {
        return UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
    }
    
    override func awakeFromNib() {
        //self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        viewBackground.clipsToBounds = true
        viewBackground.layer.cornerRadius = 15
        imageViewError.isHidden = true
    }
    
    func showLoader(msg : String) {
        DispatchQueue.main.async {  [weak self] in
            guard let self = self else { return }
            self.removeFromSuperview()
            self.imageViewError.isHidden = true
            
            guard let parentView = self.getTopViewController()?.view else { return }
            
            parentView.addSubview(self)
            self.setFrame()
            
            self.activityIndicator.isHidden = false
            self.lblmsg.text = msg
            self.activityIndicator.startAnimating()
        }
    }
    
    func setFrame() {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let parent = self.superview {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
            ])
        }
    }
    
    func getTopViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              var topVC = window.rootViewController else {
            return nil
        }

        while let presented = topVC.presentedViewController {
            topVC = presented
        }

        if let nav = topVC as? UINavigationController {
            return nav.visibleViewController
        }

        if let tab = topVC as? UITabBarController {
            return tab.selectedViewController
        }

        return topVC
    }
    
    func showError(msg : String) {
        getTopViewController()?.view.addSubview(self)
        imageViewError.isHidden = false
        setFrame()
        
        lblmsg.text = msg
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.removeFromSuperview()
         }
    }
    
    func startAnimation(){
        
        DispatchQueue.main.async(execute: {
            self.activityIndicator.startAnimating()
        })
    }
    
    //MARK: Stop loader
    func stopLoader() {
        
        DispatchQueue.main.async(execute: {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.1, animations: {
                
            }) { (_) in
                self.removeFromSuperview()
            }
        })
    }
}

/*
 calling like :
 LoadingView.sharedInstance.showLoader(msg: "loading main view ")    //-->> Start Loader
 
 LoadingView.sharedInstance.stopLoader()          //-->> Stop loader
 
 */
