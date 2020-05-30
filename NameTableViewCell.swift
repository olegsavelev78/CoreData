//
//  NameTableViewCell.swift
//  CoreData2
//
//  Created by MackBook on 30.05.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit
import RealmSwift

class NameTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
