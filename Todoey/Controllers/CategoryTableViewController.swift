//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Thomas Ingolia on 9/7/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCategories()

    }

    //MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }

    func save(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
                }

            
        }  catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
   func loadCategories() {
 
    categories = realm.objects(Category.self)
    
       tableView.reloadData()
    }
    //MARK: - Add categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen when user clicks add button on UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            //self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
           textField.placeholder = "Create New Category"
            
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
   
}
