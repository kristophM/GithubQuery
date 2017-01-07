//
//  UserDetailsViewController.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import UIKit
import Alamofire
import Toucan

class UserDetailsViewController: UIViewController {
    //Properties
    var user: User!
    var repositories = [Repository]()
    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Navbar
        navigationItem.title = user.username
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserDetails()
        getRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    func getUserDetails() {
        let requestBaseURL = Environment.staging.repositorySearchURL
        let accessToken = Environment.staging.accessToken
        Alamofire.request("\(requestBaseURL)/\(user.username!)?access_token=\(accessToken)").responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    self.user = User(json: json)
                    self.populate()
                }
            }
        })
    }
    
    func getRepositories() {
        let requestBaseURL = Environment.staging.repositorySearchURL
        let accessToken = Environment.staging.accessToken
        Alamofire.request("\(requestBaseURL)/\(user.username!)/repos?access_token=\(accessToken)").responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                if let json = response.result.value as? [Any] {
                    for rawRepo in json {
                        self.repositories.append(Repository(json: rawRepo as! [String: Any]))
                    }
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    private func populate() {
        nameLabel.text = user.name
        companyLabel.text = user.company ?? ""
        bioLabel.text = user.bio ?? ""
        if let avatarURL = user.avatarURL {
            let data = NSData(contentsOf: avatarURL as URL)
            avatarImageView.image = Toucan(image: UIImage(data: data as! Data)!).resize(CGSize(width: 20, height: 20)).maskWithEllipse().image
        }
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        cell.populate(repo: repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
