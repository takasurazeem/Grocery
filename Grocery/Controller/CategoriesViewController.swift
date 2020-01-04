//
//  ViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 03/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

 

class CategoriesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    let categories = GroceryCategory.getDummyCategories()
    let cellIdentifier = "Cell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationItem.searchController = searchController
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Categories"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! GroceryCategoryCell
        
        cell.setup(item: categories[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShoppingList", sender: self)
    }
    
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
////        let completed =
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoppingList" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category = categories[indexPath.row]
            guard let destination = segue.destination as? ShoppingListViewController else { return }
            destination.title = category.name
        }
    }
}

