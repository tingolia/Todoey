//
//  ViewController.swift
//  Todoey
//
//  Created by Thomas Ingolia on 7/30/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
  //  var itemArray = ["task1", "task2", "task3"]
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    @IBOutlet var todoeyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newItem = Item()
        newItem.title = "task1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "task2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "task3"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "todoListArray") as? [Item] {
            itemArray = items
    }
    }

// MARK - tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        if item.done == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        
        }
        return cell
    }
    //TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()

//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when add item button is pressed
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "todoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

