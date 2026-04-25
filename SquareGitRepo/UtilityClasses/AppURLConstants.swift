//
//  AppURLConstants.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation
struct APPURL {
    //https://api.github.com/orgs/square/repos
    private struct Domains {
        static let Live = "https://api.github.com/"
        static let Dev = ""
        static let TestQA = ""
    }
    
    private  struct Routes {
        static let Api = "orgs/"
    }
    
    private  struct Versions {
        static let V1 = "square/"
    }
    
    private  struct Authentication {
        static let Auth = "auth/"
    }
    
    private  static let Domain = Domains.Live
    private  static let Route = Routes.Api
    private  static let Version = Versions.V1
    private  static let Auth = Authentication.Auth
    private  static let BaseURL = Domain + Route + Version
    
    struct Urls {        
        static var Repos : String {
            return BaseURL  + "repos"
        }
    }
}
