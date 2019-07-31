//
//  ViewController.swift
//  Todoey
//
//  Created by Thomas Ingolia on 7/30/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["task1", "task2", "task3"]

    @IBOutlet var todoeyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

// MARK - tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    //TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

