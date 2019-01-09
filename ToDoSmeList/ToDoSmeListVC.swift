//
//  ToDoSmeListVC.swift
//  ToDoSmeList
//
//  Created by Esmeralda Angeles on 1/8/19.
//  Copyright © 2019 SmeAngeles. All rights reserved.
//

import UIKit

class ToDoSmeListVC: UITableViewController {
    
    var listArray =  ["To buy apples", "To buy cream",]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - TABLEVIEW DATASOURCE
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        cell.textLabel?.text = listArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - TABLEVIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType =  UITableViewCell.AccessoryType.none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType =  UITableViewCell.AccessoryType.checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: -ACTIONS
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField!
        
        let addAlert = UIAlertController(title: "Add New Item", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let add =  UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (add) in
            if textField.text!.isEmpty{
                textField.layer.borderColor =  UIColor.red.cgColor
            }else{
                self.listArray.append(textField.text!)
            }
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

