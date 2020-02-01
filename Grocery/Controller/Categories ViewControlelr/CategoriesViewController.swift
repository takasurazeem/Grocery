//
//  ViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 03/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let cellIdentifier = "categoryCell"
    
    var dataController: DataController!
    var shoppingList: ShoppingList!
    var fetchedResultsController: NSFetchedResultsController<GroceryCategory>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = shoppingList.name
        setupSearchController()
        
        setupFetchedResultsController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupSearchController() {
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    func setupFetchedResultsController() {
        let request : NSFetchRequest<GroceryCategory> = GroceryCategory.fetchRequest()
        let predicate = NSPredicate(format: "shoppingList == %@", shoppingList)
        request.predicate = predicate
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        request.sortDescriptors = [sort]
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(String(describing: shoppingList))-categories")
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            fatalError("Could not perform fetch: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoppingList" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category = fetchedResultsController.object(at: indexPath)
            guard let destination = segue.destination as? GroceryItemViewController else { return }
            destination.itemCategory = category
            destination.title = category.name
            destination.dataController = self.dataController
        } else if segue.identifier == "AddCategory" {
            guard let destination = segue.destination as? AddCategoryViewController else { return }
            destination.dataController = dataController
            destination.shoppingList = shoppingList
        }
    }
}


//MARK: Core Data Section
extension CategoriesViewController : NSFetchedResultsControllerDelegate {
    
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
            break
        }
    }

}
