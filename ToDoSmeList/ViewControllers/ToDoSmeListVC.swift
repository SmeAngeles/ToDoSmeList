//
//  ToDoSmeListVC.swift
//  ToDoSmeList
//
//  Created by Esmeralda Angeles on 1/8/19.
//  Copyright © 2019 SmeAngeles. All rights reserved.
//

import UIKit
import CoreData

class ToDoSmeListVC: UITableViewController {
    
    var listArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    //let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("\(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))")
        
        loadItems()
    }

    //MARK: - TABLEVIEW DATASOURCE
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        cell.textLabel?.text = listArray[indexPath.row].title
        
        
        cell.accessoryType = listArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TABLEVIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: -ACTIONS
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField!
        
        let addAlert = UIAlertController(title: "Add New Item", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let add =  UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (add) in
            
            
            let newItem = Item(context: self.context)
            
            if textField.text!.isEmpty{
                textField.layer.borderColor =  UIColor.red.cgColor
            }else{
                 newItem.title = textField.text!
                 newItem.done = false
                self.listArray.append(newItem)
                self.saveItems()
            }
        }
        
        addAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        addAlert.addAction(add)
        
        present(addAlert, animated: true, completion: nil)
        
    }
    
    
    func saveItems(){
  
        do{
            try self.context.save()
        }catch{
            NSLog("Problem saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
        listArray = try self.context.fetch(request)
        }catch{
            NSLog("Prolem fetching request \(error)")
        }
     }
    
}

