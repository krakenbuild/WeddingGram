//
//  MomentsTableViewCell.swift
//  Wedding
//
//  Created by Personal on 22/10/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class MomentsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMoment: UIImageView!
    @IBOutlet weak var labelMoment: UILabel!
  
  @IBOutlet weak var imageFriend: UIImageView!
  
  @IBOutlet weak var labelByMe: UILabel!
  
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
