//
//  ShoppingListsViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListsViewController: UIViewController, AddShoppingListProtocol {

    @IBOutlet weak var tableView: UITableView!

    var dataController: DataController!
    let cellIdentifier = "ShoppingListsCell"
    
    var lists : [ShoppingList] = []
    
        
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.searchController = searchController
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Lists"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let request : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        request.sortDescriptors = [sort]
        do {
            lists = try dataController.viewContext.fetch(request)
        } catch let error {
            debugPrint(error)
        }
    }

    func add(list: ShoppingList) {
        self.lists.insert(list, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func update(at indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            tableView.reloadData()
            return
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}
