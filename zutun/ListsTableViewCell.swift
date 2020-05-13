//
//  ListsTableViewCell.swift
//  zutun
//
//  Created by Gabriel Schütz on 01.06.17.
//  Copyright © 2017 Gabriel Schütz. All rights reserved.
//

import UIKit

class ListsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var listName: UILabel!
    
    /*var infoShownByThisCell: Type {
        didSet{
            updateUI()
        }
    }*/

}
