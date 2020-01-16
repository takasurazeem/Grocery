//
//  ViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 03/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit



class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let categories = _GroceryCategory.getDummyCategories()
    let cellIdentifier = "Cell"
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoppingList" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category = categories[indexPath.row]
            guard let destination = segue.destination as? ShoppingListViewController else { return }
            destination.title = category.name
        }
    }
    
}

