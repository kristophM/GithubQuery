//
//  Repository.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import Foundation

enum RepoVisibility: String {
    case publiclyVisible = "public"
    case privatelyVisible = "private"
}

class Repository {
    //Properties
    var name: String!
    var visibility: RepoVisibility!
    var forks: Int?
    var issues: Int?
    var watchers: Int?
    var description: String?
    
    init(json: [String: Any]) {
        self.name = json["name"] as! String
        if json["private"] as! Bool == true {
            self.visibility = .privatelyVisible
        } else {
            self.visibility = .publiclyVisible
        }
        self.forks = json["forks"] as? Int
        self.forks = json["issues"] as? Int
        self.watchers = json["watchers"] as? Int
        if let desc = json["description"] as? String {
            self.description = desc
        }
    }
}

//Sample JSON response 
/*
{
    "id": 37426664,
    "name": "Bloccit",
    "full_name": "kristophM/Bloccit",
    "owner": {
        "login": "kristophM",
        "id": 3528596,
        "avatar_url": "https://avatars.githubusercontent.com/u/3528596?v=3",
        "gravatar_id": "",
        "url": "https://api.github.com/users/kristophM",
        "html_url": "https://github.com/kristophM",
        "followers_url": "https://api.github.com/users/kristophM/followers",
        "following_url": "https://api.github.com/users/kristophM/following{/other_user}",
        "gists_url": "https://api.github.com/users/kristophM/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/kristophM/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/kristophM/subscriptions",
        "organizations_url": "https://api.github.com/users/kristophM/orgs",
        "repos_url": "https://api.github.com/users/kristophM/repos",
        "events_url": "https://api.github.com/users/kristophM/events{/privacy}",
        "received_events_url": "https://api.github.com/users/kristophM/received_events",
        "type": "User",
        "site_admin": false
    },
    "private": false,
    "html_url": "https://github.com/kristophM/Bloccit",
    "description": null,
    "fork": false,
    "url": "https://api.github.com/repos/kristophM/Bloccit",
    "forks_url": "https://api.github.com/repos/kristophM/Bloccit/forks",
    "keys_url": "https://api.github.com/repos/kristophM/Bloccit/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/kristophM/Bloccit/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/kristophM/Bloccit/teams",
    "hooks_url": "https://api.github.com/repos/kristophM/Bloccit/hooks",
    "issue_events_url": "https://api.github.com/repos/kristophM/Bloccit/issues/events{/number}",
    "events_url": "https://api.github.com/repos/kristophM/Bloccit/events",
    "assignees_url": "https://api.github.com/repos/kristophM/Bloccit/assignees{/user}",
    "branches_url": "https://api.github.com/repos/kristophM/Bloccit/branches{/branch}",
    "tags_url": "https://api.github.com/repos/kristophM/Bloccit/tags",
    "blobs_url": "https://api.github.com/repos/kristophM/Bloccit/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/kristophM/Bloccit/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/kristophM/Bloccit/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/kristophM/Bloccit/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/kristophM/Bloccit/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/kristophM/Bloccit/languages",
    "stargazers_url": "https://api.github.com/repos/kristophM/Bloccit/stargazers",
    "contributors_url": "https://api.github.com/repos/kristophM/Bloccit/contributors",
    "subscribers_url": "https://api.github.com/repos/kristophM/Bloccit/subscribers",
    "subscription_url": "https://api.github.com/repos/kristophM/Bloccit/subscription",
    "commits_url": "https://api.github.com/repos/kristophM/Bloccit/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/kristophM/Bloccit/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/kristophM/Bloccit/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/kristophM/Bloccit/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/kristophM/Bloccit/contents/{+path}",
    "compare_url": "https://api.github.com/repos/kristophM/Bloccit/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/kristophM/Bloccit/merges",
    "archive_url": "https://api.github.com/repos/kristophM/Bloccit/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/kristophM/Bloccit/downloads",
    "issues_url": "https://api.github.com/repos/kristophM/Bloccit/issues{/number}",
    "pulls_url": "https://api.github.com/repos/kristophM/Bloccit/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/kristophM/Bloccit/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/kristophM/Bloccit/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/kristophM/Bloccit/labels{/name}",
    "releases_url": "https://api.github.com/repos/kristophM/Bloccit/releases{/id}",
    "deployments_url": "https://api.github.com/repos/kristophM/Bloccit/deployments",
    "created_at": "2015-06-14T19:37:08Z",
    "updated_at": "2015-06-14T19:39:13Z",
    "pushed_at": "2015-08-18T14:21:54Z",
    "git_url": "git://github.com/kristophM/Bloccit.git",
    "ssh_url": "git@github.com:kristophM/Bloccit.git",
    "clone_url": "https://github.com/kristophM/Bloccit.git",
    "svn_url": "https://github.com/kristophM/Bloccit",
    "homepage": null,
    "size": 427,
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "Ruby",
    "has_issues": true,
    "has_downloads": true,
    "has_wiki": true,
    "has_pages": false,
    "forks_count": 0,
    "mirror_url": null,
    "open_issues_count": 0,
    "forks": 0,
    "open_issues": 0,
    "watchers": 0,
    "default_branch": "master",
    "permissions": {
        "admin": true,
        "push": true,
        "pull": true
    }
}
*/
