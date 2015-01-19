//
//  Cell.swift
//  Swiftagram
//
//  Created by Mark on 1/19/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    // cell properties
    @IBOutlet var postedImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
