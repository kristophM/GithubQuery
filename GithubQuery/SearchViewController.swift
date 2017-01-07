//
//  SearchViewController.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import UIKit
import Alamofire
class SearchViewController: UIViewController {
    //Properties
    var users = [User]()
    var selectedUser: User?
    //Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.addTarget(self, action: #selector(searchFieldDidChange), for: .editingChanged)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.alpha = CGFloat(0.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.logoImageView.alpha = CGFloat(0.0)
            self.tableView.alpha = CGFloat(1.0)
        }, completion: nil)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToDetailSegue" {
            let vc = segue.destination as! UserDetailsViewController
            vc.user = selectedUser!
        }
    }
    
    //Search
    func searchFieldDidChange(sender: UITextField) {
        //Show search results and call autocomplete API. If becomes blank, clear table
        users = []
        if sender.text! == "" {
            tableView.reloadData()
        } else {
            //If text altered, show table and put in cover under search bar
            if sender.text!.characters.count >= 3 {
                //Call autocomplete API
                searchForUsers()
            }
        }
    }
    
    func searchForUsers() {
        let requestBaseURL = Environment.staging.userSearchURL
        let accessToken = Environment.staging.accessToken
        Alamofire.request("\(requestBaseURL)?q=\(searchTextField.text!)&per_page=10&access_token=\(accessToken)").responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    if let items = json["items"] as? [[String: Any]] {
                        for rawUser in items {
                            self.users.append(User(json: rawUser))
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        })
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if users.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            cell.populate(user: users[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUser = users[indexPath.row]
        performSegue(withIdentifier: "searchToDetailSegue", sender: self)
    }
}
