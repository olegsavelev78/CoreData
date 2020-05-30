//
//  ViewController.swift
//  CoreData2
//
//  Created by MackBook on 27.05.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var secondNameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextfield.placeholder = "Введите имя"
        secondNameTextfield.placeholder = "Введите фамилию"
        nameTextfield.text = Persistance.shared.userName
        secondNameTextfield.text = Persistance.shared.userSecondName
    }
    
    @IBAction func saveButton(_ sender: Any) {
        Persistance.shared.userName = nameTextfield.text
        Persistance.shared.userSecondName = secondNameTextfield.text
    }
    
}

