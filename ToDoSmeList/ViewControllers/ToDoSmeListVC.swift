//
//  ToDoSmeListVC.swift
//  ToDoSmeList
//
//  Created by Esmeralda Angeles on 1/8/19.
//  Copyright © 2019 SmeAngeles. All rights reserved.
//

import UIKit

class ToDoSmeListVC: UITableViewController {
    
    var listArray = [Item]()
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy peraples"
        listArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy apples"
        listArray.append(newItem2)

        
        let newItem3 =  Item()
        newItem3.title =  "Buy coffe"
        listArray.append(newItem3)

        if let items = userDefaults.array(forKey: "ToDoListArray") as? [Item]{
            listArray = items
        }
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
        
        self.tableView.reloadData()
    
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: -ACTIONS
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField!
        
        let addAlert = UIAlertController(title: "Add New Item", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let add =  UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (add) in
            
            let newItem = Item()
  
            
            if textField.text!.isEmpty{
                textField.layer.borderColor =  UIColor.red.cgColor
            }else{
                 newItem.title = textField.text!
                self.listArray.append(newItem)
            }
            self.userDefaults.set(self.listArray, forKey: "ToDoListArray")

            self.tableView.reloadData()
        }
        
        addAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        addAlert.addAction(add)
        
        present(addAlert, animated: true, completion: nil)
        
    }
    
}

