//
//  PostCell.swift
//  instagramClone
//
//  Created by Godwin Pang on 2/26/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {

    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var instagramPost: Post! {
        didSet {
            self.photoView.file = instagramPost["media"] as? PFFile
            self.captionLabel.text = instagramPost["caption"] as? String
            self.photoView.loadInBackground()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
