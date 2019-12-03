//
//  CRTTableViewCell.swift
//  NumberTheoryToTheMax
//
//  Created by Madison Williams on 11/20/19.
//  Copyright © 2019 Zukosky, Jonah. All rights reserved.
//

import UIKit

class CRTTableViewCell: UITableViewCell {

    @IBOutlet weak var congruencyLabel: UILabel!
    @IBOutlet weak var modLabel: UILabel!
    @IBOutlet weak var parenthesesLabel: UILabel!
    @IBOutlet weak var num1TextField: UITextField!// as! CRTTextField
    @IBOutlet weak var num2TextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        congruencyLabel.text = " X \u{2261} "
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
