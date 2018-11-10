//
//  HomeTableViewCell.swift
//  Instagrum
//
//  Created by AUNG PHYO on 11/9/18.
//  Copyright © 2018 AUNG PHYO. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoView: PFImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var homePost: PFObject! {
        didSet {
            self.captionLabel.text = homePost["caption"] as? String
            let photo = homePost["photo"] as! PFObject
            self.photoView.file = photo["image"] as? PFFile
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
