//
//  Configuration.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import Foundation

enum Environment: String {
    case staging = "staging"
    case production = "production"
    
    //API
    var accessToken: String {
        switch self {
        case .staging:
            return "a2d8a63102195a81ece719c19a86ad582ba7c758"
        case .production:
            return ""
        }
    }
    var userSearchURL: String {
        switch self {
        case .staging:
            return "https://api.github.com/search/users"
        case .production:
            return ""
        }
    }
    var repositorySearchURL: String {
        switch self {
        case .staging:
            return "https://api.github.com/users"
        case .production:
            return ""
        }
    }
}
