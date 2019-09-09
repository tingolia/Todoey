//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Thomas Ingolia on 9/7/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {

  var categories = [Category]()
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    //MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    func saveCategories() {
        
        do {
            try context.save()
            
        }  catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
            
        } catch {
            print("Error loading categories: \(error)")
        }
        tableView.reloadData()
    }
    //MARK: - Add categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen when user clicks add button on UIAlert
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            self.tableView.reloadData()
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
   
}
