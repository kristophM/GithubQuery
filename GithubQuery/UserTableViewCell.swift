//
//  UserTableViewCell.swift
//  GithubQuery
//
//  Created by Kristoph Matthews on 1/7/17.
//  Copyright © 2017 KristophMatthews. All rights reserved.
//

import UIKit
import Toucan
import SDWebImage

class UserTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.image = UIImage(named: "profile-photo-placeholder")
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Functions
    func populate(user: User) {
        let block: SDWebImageCompletionBlock = { (image, error, cacheType, imageURL) -> Void in
            guard imageURL != nil else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = Toucan(image: image!).resize(CGSize(width: 20, height: 20), fitMode: .crop).maskWithEllipse().image
            }
        }
        if let avatarURL = user.avatarURL {
            avatarImageView.sd_setImage(with: avatarURL as URL, placeholderImage: UIImage(named: "profile-photo-placeholder"), options: SDWebImageOptions.lowPriority, completed: block)
        }
        usernameLabel.text = user.username
    }

}
