//
//  CoreDataViewController.swift
//  CoreData2
//
//  Created by MackBook on 29.05.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit
import CoreData
class TodoCoreDataViewController:  UIViewController{
    
    @IBOutlet weak var todoTableView: UITableView!
    
    var arraytasks = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
        
        
    }
  
    @IBAction func addTask(_ sender: UIButton) {
        // Создание alert
        var textField = UITextField()
        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Сохранить", style: .default) { (action) in
            let newTask = Task(context: self.context)
            newTask.name = textField.text!
            self.arraytasks.append(newTask)
            self.saveName()
        }

        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Новая задача"
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveName(){
        
        do {
            try context.save()
        } catch {
            print("Error saving task with \(error)")
        }
        todoTableView.reloadData()
    }
    func loadTasks(){
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do{
          arraytasks = try context.fetch(request)
        } catch {
            print("error")
        }
        todoTableView.reloadData()
    }
    
    
    
}
extension TodoCoreDataViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arraytasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "MyCell") as! DataCoreTableViewCell
        let task = arraytasks[indexPath.row]
        cell.textLabel?.text = task.name
        cell.accessoryType = task.completed ? .checkmark : .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoTableView.deselectRow(at: indexPath, animated: true)
        
        arraytasks[indexPath.row].completed = !arraytasks[indexPath.row].completed
        saveName()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                    completionHandler(true)
            let task = self.arraytasks[indexPath.row]
            self.arraytasks.remove(at: indexPath.row)
            self.context.delete(task)
            do{
                try self.context.save()
            } catch {
                print(error)
            }
            self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let update = UIContextualAction(style: .normal, title: "Изменить") { (action, view, completionHandler) in
            completionHandler(true)
            var name = self.arraytasks[indexPath.row]
            let alert2 = UIAlertController(title: "Изменить задачу", message: nil, preferredStyle: .alert)
            var textField2 = UITextField()
            alert2.addTextField { text in
                textField2 = text
                text.text = name.name
            }
            

            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
                let newTask = textField2.text!
                do{
                    self.arraytasks = try self.context.fetch(Task.fetchRequest())
                } catch {
                    print(error)
                }
                name.setValue(newTask, forKey: "name")
                do { try self.context.save()}
                catch { print("error")}
                self.todoTableView.reloadData()
                }

                let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)

                alert2.addAction(saveAction)
                alert2.addAction(cancelAction)

            self.present(alert2, animated: true, completion: nil)
        }
    
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, update])
    
                return swipe
            }
}
    
    
    


















//class TodoCoreDataViewController: UIViewController {
//
//    @IBOutlet weak var toDoListCoreDataTableView: UITableView!
//
//    var arrayTask = [NSManagedObject]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Task")
//        let result = try? managedContext.fetch(fetchRequest) as? [NSManagedObject]
//        arrayTask = result!
//        toDoListCoreDataTableView.reloadData()
//
//        // Do any additional setup after loading the view.
//    }
//
//
    // Сохранение в Core Data
//    func saveName(name: String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity =  NSEntityDescription.entity(forEntityName: "Task",in: managedContext)!
//        let person = NSManagedObject(entity: entity, insertInto: managedContext)
//        person.setValue(name, forKeyPath: "name")
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Данные не сохранены. \(error), \(error.userInfo)")
//        }
//      arrayTask.append(person)
//    }
//
//    @IBAction func addTask(_ sender: Any) {
//        // Создание alert
//        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
//
//        alert.addTextField { textField in
//            textField.placeholder = "Новая задача"
//        }
//
//        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
//
//            let textField = (alert.textFields?.first?.text)!
//            self.saveName(name: textField)
//            self.toDoListCoreDataTableView.reloadData()
//        }
//
//        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
//
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true, completion: nil)
//
//    }
//    }

//extension TodoCoreDataViewController: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayTask.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = toDoListCoreDataTableView.dequeueReusableCell(withIdentifier: "MyCell") as! DataCoreTableViewCell
//        let task = arrayTask[indexPath.row]
//        cell.textLabel?.text = task.value(forKey: "name") as? String
//
//        cell.accessoryType = (task.value(forKey: "completed") as? Bool)! ? .checkmark : .none
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        toDoListCoreDataTableView.deselectRow(at: indexPath, animated: true)
//
//        var check = (arrayTask[indexPath.row].value(forKey: "completed") as? Bool)!
//
//        check = !check
//    }
//
//
//
//
//
//
//
//
//
//
//    func deleteTask(name: NSManagedObject){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//          let managedContext = appDelegate.persistentContainer.viewContext
//          do {
//            managedContext.delete(name)
//            do {
//                try managedContext.save()
//
//            } catch {
//                print(error)
//
//            }
//          }
//    }
//
//    // Редактировать ячейку
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
//            completionHandler(true)
//        }
//
//        let swipe = UISwipeActionsConfiguration(actions: [delete])
//
////        let update = UIContextualAction(style: .normal, title: "Изменить") { (action, view, completionHandler) in
////            completionHandler(true)
////        }
////
////        let deleteTask = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
////            completionHandler(true)
////            let task = self.arrayTask[indexPath.row]
////            self.deleteTask(name: task)
////            self.arrayTask.remove(at: indexPath.row)
////            self.toDoListCoreDataTableView.reloadData()
////        }
////
////        let configuration = UISwipeActionsConfiguration(actions: [deleteTask])
////
//        return swipe
//    }
//
//
//
//    // Удаление ячейки
////    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
////
////        return .delete
////    }
////    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
////        if editingStyle == .delete {
////            let task = arrayTask[indexPath.row]
////            self.deleteTask(name: task)
////            arrayTask.remove(at: indexPath.row)
////            toDoListCoreDataTableView.reloadData()
////        }
////
////
////    }
//}
