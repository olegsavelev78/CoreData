//
//  RealmViewController.swift
//  CoreData2
//
//  Created by MackBook on 27.05.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {
    @IBOutlet weak var toDoListTableView: UITableView!
        
        var arrayTask: Results<Tasks>{
            get {
                return realm.objects(Tasks.self)
            }
        }
        
        var realm: Realm!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            realm = try! Realm()
            
            toDoListTableView.estimatedRowHeight = 50
            toDoListTableView.rowHeight = UITableView.automaticDimension
        
        }
        
        @IBAction func addTask(_ sender: Any) {
            
            // Создание alert
            let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)

            alert.addTextField { textField in
                textField.placeholder = "Новая задача"
            }

            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
                let todoTextfield = (alert.textFields?.first)! as UITextField
                let task = Tasks()
                
                task.task = todoTextfield.text!
                task.done = false
                
                try! self.realm.write{
                    self.realm.add(task)
                    self.toDoListTableView.insertRows(at: [IndexPath.init(row: self.arrayTask.count - 1, section: 0)], with: .automatic)
                }
                
                self.toDoListTableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)

            alert.addAction(saveAction)
            alert.addAction(cancelAction)

            present(alert, animated: true, completion: nil)
        }
        }



    extension RealmViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayTask.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "Cell") as! RealmTableViewCell
            let name = self.arrayTask[indexPath.row]
            cell.labelTask.text = name.task
            if name.done == true{
                    cell.imageBttn.setImage(UIImage.init(systemName: "largecircle.fill.circle"), for: .normal)
                    cell.imageBttn.tintColor = UIColor.blue
                    }else {
                cell.imageBttn.setImage(UIImage.init(systemName: "circle"), for: .normal)
                cell.imageBttn.tintColor = UIColor.black
            }
            cell.bttnAction = { sender in
                self.toDoListTableView.reloadData()
                
                try! self.realm.write{
                    name.done = !name.done
                }
                
                print(name.done)
                
            }
            
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            toDoListTableView.deselectRow(at: indexPath, animated: true)
            let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "Cell") as! RealmTableViewCell
            let name = self.arrayTask[indexPath.row]

    
            let alert2 = UIAlertController(title: "Изменить задачу", message: nil, preferredStyle: .alert)

            alert2.addTextField { text in
                text.text = name.task
            }

            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
                try! self.realm.write {
                    self.arrayTask[indexPath.row].task = (alert2.textFields?.first?.text)!
                    self.realm.add(self.arrayTask[indexPath.row])
                }
                self.toDoListTableView.reloadData()
            }

            let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)

            alert2.addAction(saveAction)
            alert2.addAction(cancelAction)

            present(alert2, animated: true, completion: nil)
            
        }
        
        // Удаление ячейки
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            
            return .delete
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete  {
                try! self.realm.write{
                    self.realm.delete(arrayTask[indexPath.row])
                }
                toDoListTableView.deleteRows(at: [indexPath], with: .left)
            }
        }
 
        
    }
