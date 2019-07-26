//
//  ViewController.swift
//  Todoey
//
//  Created by Saul Juan Antonio Lionheart Cuautle on 7/20/19.
//  Copyright © 2019 Saul Juan Antonio Lionheart Cuautle. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
       loadItems()
        }
    }
    
        //now a global constant
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        //don't need dataFilePath anymore
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       // loadItems()
        
    }

        
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
        
      //  loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }

    
    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // print("cellForRowAtIndexPath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        let item = todoItems?[indexPath.row] ??
        
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
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("error savind done status, \(error)")
            }
        }
        
        tableView.reloadData()
        //print(itemArray[indexPath.row])

        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
       //ordering matters
        
       // todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
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
        
       // saveItems()
        
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
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("error saving new itmes, \(error)")
                }
            }
            
            tableView.reloadData()
//
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//
//            self.itemArray.append(newItem)
            
           // self.saveItems()
            
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
    func saveCategories() {
        //no longer inside a closure...
        //let encoder = PropertyListEncoder()  no longer using encoder
        
        do {
            //let data = try encoder.encode(itemArray)
            //try data.write(to: dataFilePath!)
            //try context.save()
            try realm.write {
                realm.add(category)
            }
        } catch {
            //print("error encoding item array, \(error)")
            print("error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//            itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item \(error)")
//            }
//        }
//    }
    func loadItems() {
    
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
}

//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        //let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate!])
////
////        request.predicate = compoundPredicate
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("error fetching data from context \(error)")
//        }
//        tableView.reloadData()
    //}
    
//}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
}

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

}
