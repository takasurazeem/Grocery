//
//  ShoppingListsViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

class GroceryListViewController: UIViewController, UISearchControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var dataController: DataController!
    let cellIdentifier = "ShoppingListsCell"
    
    
    var fetchedResultsController: NSFetchedResultsController<ShoppingList>!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchController()
        setupFetchedResultsController()
        if let text = searchController.searchBar.text, !text.isEmpty {
            filterContentForSearchText(text)
        }
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    func setupSearchController() {
        self.navigationController?.navigationItem.searchController = searchController
        // 1
        searchController.searchResultsUpdater = self
        searchController.delegate = self
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
    
    func setupFetchedResultsController() {
        let request : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        request.sortDescriptors = [sort]
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "ShoppingLists")
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            fatalError("Could not perform fetch: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: Complete it
        let searchText = searchController.searchBar.text ?? ""
        var predicate: NSPredicate?
        if searchText.count > 0 {
            NSFetchedResultsController<ShoppingList>.deleteCache(withName: "ShoppingList")
            predicate = NSPredicate(format: "name contains[c] %@", searchText)
        } else {
            predicate = nil
        }
        
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let err {
            print(err)
        }
        if let objects = fetchedResultsController.fetchedObjects {
            for o in objects {
                print(o.name!)
            }
        }
    }
    
    func filterContentForSearchText(_ searchTerm: String) {
        print(searchTerm)
        var predicate: NSPredicate?
        if searchTerm.count > 0 {
//            predicate = NSPredicate(format: "(name contains[cd] %@) || (artist.name contains[cd] %@)", searchText, searchText)
            predicate = NSPredicate(format: "name CONTAINS[c] %@", searchTerm)
        } else {
            predicate = nil
        }
        fetchedResultsController.fetchRequest.predicate = predicate
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let err {
            print(err)
        }
    }
}

//MARK: Core Data Section
extension GroceryListViewController : NSFetchedResultsControllerDelegate {
    
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
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        default:
            tableView.reloadData()
        }
    }
}
