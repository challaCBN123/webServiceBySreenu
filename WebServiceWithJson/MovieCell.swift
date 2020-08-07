//
//  MovieCell.swift
//  WebServiceWithJson
//
//  Created by SRINIVASULU on 29/09/19.
//  Copyright © 2019 SRINIVASULU. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet var lbl_Name: UILabel!
    @IBOutlet var lbl_Details: UILabel!
    @IBOutlet var lbl_Actor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
