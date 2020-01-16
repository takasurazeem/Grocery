//
//  ShoppingListViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 04/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListViewController: UIViewController {
    
    let items = _GroceryItems.getGroceryItems()
    let cellIdentifier = "GroceryItemCell"
    
    let itemsDone = UIBarButtonItem(title: "3/10", style: .plain, target: nil, action: nil)
    var dataController: DataController!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddItem: UIButton!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.searchController = searchController
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search List"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        itemsDone.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .disabled)
        itemsDone.isEnabled = false
        self.navigationItem.rightBarButtonItem = itemsDone
    }
    
    @IBAction func btnAddItemPressed(_ sender: Any) {
        
    }
    
}
