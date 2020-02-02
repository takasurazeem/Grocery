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
    
    func save() {
        do {
            try dataController.viewContext.save()
        } catch let error {
            debugPrint("Error: \(error)")
        }
    }
    
}
