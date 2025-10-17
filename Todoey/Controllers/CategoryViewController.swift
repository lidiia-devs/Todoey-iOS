//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Lidiia Diachkovskaia on 10/15/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        navigationController?.navigationBar.tintColor = .white
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemTeal
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                              .font: UIFont.boldSystemFont(ofSize: 25)]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
        //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
        //MARK: - Data Manipulation Methods
        
    func saveCategories() { //we need saveItems() func for CUD from CRUD (no Read)
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
        func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) { //Category.fetchRequest - default. This one needs for Read from CRUD
            //  let request : NSFetchRequest<Category> = Category.fetchRequest()// you need to specify the output data type e.g.: <Category>
                do {
                    categories = try context.fetch(request)
                } catch {
                    print("Error fetching categories from context \(error)")
                }
                    tableView.reloadData()
            }

    
        //MARK: - Add New Categories
        
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                //what will happen once the user clicks the Add Item button on our UIAlert
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!

                self.categories.append(newCategory)
    
                self.saveCategories()
            }
            
            alert.addAction(action)
            
            alert.addTextField { (alertTextField) in
                textField = alertTextField
                alertTextField.placeholder = "Create a new category"
            }
            
            present(alert, animated: true, completion: nil)
        }
        

        
}
