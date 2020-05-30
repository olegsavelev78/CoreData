//
//  RealmTableViewCell.swift
//  CoreData2
//
//  Created by MackBook on 27.05.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTableViewCell: UITableViewCell {
    var bttnAction: ((Any) -> Void)?
    
        override func awakeFromNib() {
            super.awakeFromNib()
            
            // Initialization code
        }
        @IBOutlet weak var imageBttn: UIButton!
        @IBOutlet weak var labelTask: UILabel!
    
            
        @IBAction func checkBttn(_ sender: UIButton) {
            self.bttnAction?(sender)
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {

            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }

    }
