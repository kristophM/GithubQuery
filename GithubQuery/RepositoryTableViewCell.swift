//
//  RepositoryTableViewCell.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var watchersLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(repo: Repository) {
        titleLabel.text = repo.name
        descriptionLabel.text = repo.description ?? ""
        watchersLabel.text = String(repo.watchers ?? 0)
    }

}
