//
//  ViewController.swift
//  Todoey
//
//  Created by Thomas Ingolia on 7/30/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var toDoItems: Results<Item>?
  
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
        loadItems()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
        @IBOutlet var todoeyTableView: UITableView!

// MARK - tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
                    cell.accessoryType = item.done ? .checkmark : .none
        } else {
            
        cell.textLabel?.text = "No Items Added"
        }
       
        return cell
    }
    //TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
            }
            } catch {
                print("Error changing done status: \(error)")
            }
            tableView.reloadData()
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when add item button is pressed
            
            if let currentCategory = self.selectedCategory {
                do {
                    let currentDateTime = Date()
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                        newItem.dateCreated = currentDateTime
                    currentCategory.items.append(newItem)
               
            }
            
                } catch {
                    print("Error saving new items \(error)")
                }
            }
                self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    func loadItems() {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
       
        tableView.reloadData()
    }
}
// MARK - Search funtionality
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)

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


