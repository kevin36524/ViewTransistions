//
//  TempTableViewCell.swift
//  ViewTransitions
//
//  Created by Kevin Balvantkumar Patel on 2/23/17.
//  Copyright © 2017 LZChat. All rights reserved.
//

import UIKit

class TempTableViewCell: UITableViewCell {
    static let celluniqueIdentifier = "TempTableViewCellID"

    @IBOutlet weak var cellLabel: UILabel!
    
    var cellData: String? {
        didSet{
            if let newValue = cellData {
                cellData = newValue
                cellLabel?.text = cellData
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellLabel?.text = cellData
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
