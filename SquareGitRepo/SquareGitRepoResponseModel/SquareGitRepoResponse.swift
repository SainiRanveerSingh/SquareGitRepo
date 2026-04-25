//
//  SquareGitRepoResponse.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation

import Foundation

// MARK: - Root
typealias SquareGitRepoResponse = [SquareGitRepoResponseElement]

// MARK: - Repo
struct SquareGitRepoResponseElement: Codable {
    let id: Int?
    let nodeID: String?
    let name: String?
    let fullName: String?
    let isPrivate: Bool?
    let owner: Owner?

    let htmlURL: String?
    let description: String?
    let fork: Bool?
    let url: String?

    let createdAt: String?
    let updatedAt: String?
    let pushedAt: String?

    let homepage: String?
    let size: Int?
    let stargazersCount: Int?
    let watchersCount: Int?
    let language: String?

    let hasIssues: Bool?
    let hasProjects: Bool?
    let hasDownloads: Bool?
    let hasWiki: Bool?
    let hasPages: Bool?
    let hasDiscussions: Bool?

    let forksCount: Int?
    let archived: Bool?
    let disabled: Bool?
    let openIssuesCount: Int?

    let license: License?
    let allowForking: Bool?
    let isTemplate: Bool?
    let hasPullRequests: Bool?

    let visibility: String?
    let forks: Int?
    let openIssues: Int?
    let watchers: Int?
    let defaultBranch: String?

    let permissions: Permissions?
    let customProperties: CustomProperties?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description, fork, url

        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"

        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language

        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"

        case forksCount = "forks_count"
        case archived, disabled
        case openIssuesCount = "open_issues_count"

        case license
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case hasPullRequests = "has_pull_requests"

        case visibility, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"

        case permissions
        case customProperties = "custom_properties"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?

    let url: String?
    let htmlURL: String?
    let followersURL: String?

    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?

    let subscriptionsURL: String?
    let organizationsURL: String?
    let reposURL: String?

    let eventsURL: String?
    let receivedEventsURL: String?

    let type: String?
    let userViewType: String?
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}

// MARK: - License
struct License: Codable {
    let key: String?
    let name: String?
    let spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: - Permissions
struct Permissions: Codable {
    let admin: Bool?
    let maintain: Bool?
    let push: Bool?
    let triage: Bool?
    let pull: Bool?
}

// MARK: - Custom Properties
struct CustomProperties: Codable {
    let codeReviewPolicy: String?
    let sensitivityLevel: String?

    enum CodingKeys: String, CodingKey {
        case codeReviewPolicy = "CodeReviewPolicy"
        case sensitivityLevel = "SensitivityLevel"
    }
}
//---- 00 ----
/*
// MARK: - Root
typealias SquareGitRepoResponse = [SquareGitRepoResponseElement]

// MARK: - Repo
struct SquareGitRepoResponseElement: Codable {
    let id: Int?
    let nodeID, name, fullName: String?
    let isPrivate: Bool?
    let owner: Owner?
    let htmlURL: String?
    let description: String?
    let fork: Bool?
    let url: String?
    
    let createdAt, updatedAt, pushedAt: Date?
    
    let gitURL, sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: String?
    
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    let hasPages, hasDiscussions: Bool?
    
    let forksCount: Int?
    let mirrorURL: String?
    let archived, disabled: Bool?
    let openIssuesCount: Int?
    
    let license: License?
    
    let allowForking, isTemplate, webCommitSignoffRequired, hasPullRequests: Bool?
    
    let pullRequestCreationPolicy: String?
    let topics: [String]?
    let visibility: String?
    
    let forks, openIssues, watchers: Int?
    let defaultBranch: String?
    
    let permissions: Permissions?
    let customProperties: CustomProperties?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description, fork, url
        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage
        
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"
        
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        
        case license
        
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case webCommitSignoffRequired = "web_commit_signoff_required"
        case hasPullRequests = "has_pull_requests"
        
        case pullRequestCreationPolicy = "pull_request_creation_policy"
        case topics, visibility, forks
        
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        
        case permissions
        case customProperties = "custom_properties"
    }
}

//---

//MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    
    let url, htmlURL, followersURL: String?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    
    let type: String?
    let userViewType: String?
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}

//---

//MARK: - License
struct License: Codable {
    let key: String?
    let name: String?
    let spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

//---

//MARK: - Permissions
struct Permissions: Codable {
    let admin, maintain, push, triage: Bool?
    let pull: Bool?
}

//---

//MARK: - Custom Properties
struct CustomProperties: Codable {
    let codeReviewPolicy: CodeReviewPolicy?
    let sensitivityLevel: SensitivityLevel?

    enum CodingKeys: String, CodingKey {
        case codeReviewPolicy = "CodeReviewPolicy"
        case sensitivityLevel = "SensitivityLevel"
    }
}

enum CodeReviewPolicy: String, Codable {
    case standard
}

enum SensitivityLevel: String, Codable {
    case l0 = "L0"
}
*/
