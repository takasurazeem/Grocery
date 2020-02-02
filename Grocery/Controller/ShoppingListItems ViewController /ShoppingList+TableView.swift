//
//  File.swift
//  Grocery
//
//  Created by Takasur Azeem on 05/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension GroceryItemViewController : UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
            indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            let item = fetchedResultsController.object(at: indexPath)
            item.completed = !item.completed
            save()
            return nil
        }
        let item = fetchedResultsController.object(at: indexPath)
        item.completed = !item.completed
        save()
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GroceryItemCell
        
        let item = fetchedResultsController.object(at: indexPath)
        cell.setup(item: item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            let itemToDelete = self.fetchedResultsController.object(at: indexPath)
            self.dataController.viewContext.delete(itemToDelete)
            self.save()
            completion(true)
        }
        
        
        let update = UIContextualAction(style: .normal, title: "Update") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            guard let destination = self.storyboard?.instantiateViewController(identifier: "AddItemViewController") as? AddItemViewController else { return }
            let itemToUpdate = self.fetchedResultsController.object(at: indexPath)
            destination.itemToUpdate = itemToUpdate
            destination.dataController = self.dataController
            destination.itemCategory = self.itemCategory
            self.present(destination, animated: true, completion: nil)
        }
        
        return UISwipeActionsConfiguration(actions: [delete, update])
    }
    
    func save() {
        do {
            try dataController.viewContext.save()
        } catch let error {
            debugPrint("Error: \(error)")
        }
    }
    
}
