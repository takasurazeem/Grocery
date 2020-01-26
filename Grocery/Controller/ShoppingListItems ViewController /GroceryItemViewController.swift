//
//  ShoppingListViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 04/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

class GroceryItemViewController: UIViewController {
    
    let cellIdentifier = "GroceryItemCell"
    let searchController = UISearchController(searchResultsController: nil)
    let itemsDone = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<GroceryItem>!
    var itemCategory: GroceryCategory!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddItem: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        setupSearchController()
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        updateItemsDoneOverTotalItemsLabel()
    }
    
    func updateItemsDoneOverTotalItemsLabel() {
        if let items = fetchedResultsController.fetchedObjects {
            var totalItems = items.count
            if totalItems == 0 {
                itemsDone.title = ""
                return
            }
            var itemsDone = 0
            items.forEach { (item) in
                if item.completed {
                    itemsDone += 1
                }
            }
            self.itemsDone.title = "\(itemsDone)/\(totalItems)"
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    
    func setupFetchedResultsController() {
        let request : NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        let predicate = NSPredicate(format: "category == %@", itemCategory)
        request.predicate = predicate
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        request.sortDescriptors = [sort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(itemCategory)-items")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            fatalError("Could not perform fetch: \(error)")
        }
    }
    
    func setupSearchController() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            guard let destination = segue.destination as? AddItemViewController else {
                fatalError("Check your class")
            }
            destination.dataController = dataController
            destination.itemCategory = itemCategory
        }
    }
    
}

extension GroceryItemViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
            updateItemsDoneOverTotalItemsLabel()
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            updateItemsDoneOverTotalItemsLabel()
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
            updateItemsDoneOverTotalItemsLabel()
        default:
            break
        }
    }
}
