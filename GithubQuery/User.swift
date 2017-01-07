//
//  User.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import Foundation

class User {
    //Properties
    var username: String!
    var avatarURL: NSURL?
    var id: Int!
    var score: Double?
    var name: String?
    var bio: String?
    var company: String?
    
    init(username: String, avatarURL: NSURL?, id: Int, score: Double) {
        self.username = username
        self.avatarURL = avatarURL
        self.id = id
        self.score = score
    }
    
    init(json: [String: Any]) {
        self.username = json["login"] as! String
        if let avatarURLString = json["avatar_url"] as? String {
            self.avatarURL = NSURL(string: avatarURLString)!
        }
        self.id = json["id"] as! Int
        self.score = json["score"] as? Double
        if let name = json["name"] as? String {
            self.name = name
        }
        if let bio = json["bio"] as? String {
            self.bio = bio
        }
        if let company = json["company"] as? String {
            self.company = company
        }
    }
}

//Example response from JSON API
//"login": "kristophM",
//"id": 3528596,
//"avatar_url": "https://avatars.githubusercontent.com/u/3528596?v=3",
//"gravatar_id": "",
//"url": "https://api.github.com/users/kristophM",
//"html_url": "https://github.com/kristophM",
//"followers_url": "https://api.github.com/users/kristophM/followers",
//"following_url": "https://api.github.com/users/kristophM/following{/other_user}",
//"gists_url": "https://api.github.com/users/kristophM/gists{/gist_id}",
//"starred_url": "https://api.github.com/users/kristophM/starred{/owner}{/repo}",
//"subscriptions_url": "https://api.github.com/users/kristophM/subscriptions",
//"organizations_url": "https://api.github.com/users/kristophM/orgs",
//"repos_url": "https://api.github.com/users/kristophM/repos",
//"events_url": "https://api.github.com/users/kristophM/events{/privacy}",
//"received_events_url": "https://api.github.com/users/kristophM/received_events",
//"type": "User",
//"site_admin": false,
//"score": 45.397903
