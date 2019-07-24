//
//  ViewController.swift
//  Todoey
//
//  Created by Saul Juan Antonio Lionheart Cuautle on 7/20/19.
//  Copyright © 2019 Saul Juan Antonio Lionheart Cuautle. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
        //now a global constant
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "1989"
//        itemArray.append(newItem)
//       
//        let newItem2 = Item()
//        newItem2.title = "Reputation"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Lover"
//        itemArray.append(newItem3)
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
    }

    
    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // print("cellForRowAtIndexPath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        saveItems()
        
        //tableView.reloadData()  -->exists inside saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks Add Item button on our UIAlert
            //print("Success mofo!")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
//            let encoder = PropertyListEncoder()
//            do {
//                let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//            } catch {
//                print("error encoding item array, \(error)")
//            }
//
//            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            //print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        //no longer inside a closure...
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item \(error)")
            }
        }
    }
    
}

