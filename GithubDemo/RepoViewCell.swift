//
//  RepoViewCell.swift
//  GithubDemo
//
//  Created by Ben Jones on 10/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RepoViewCell: UITableViewCell {
    

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
