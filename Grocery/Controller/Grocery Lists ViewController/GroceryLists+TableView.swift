//
//  ShoppingLists+TableViewDelegateDataSourse.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

extension GroceryListViewController : UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GroceryListCell
        
        cell.setup(with: fetchedResultsController.object(at: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Categories", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            
            let listToDelte = self.fetchedResultsController.object(at: indexPath)
            self.dataController.viewContext.delete(listToDelte)
            do {
                try self.dataController.viewContext.save()
            } catch let error {
                debugPrint(error)
            }
            completion(true)
        }

        deleteAction.image = UIGraphicsImageRenderer(size: CGSize(width: 35, height: 35)).image { _ in
            UIImage(named: "delete")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
        }

        deleteAction.backgroundColor = #colorLiteral(red: 0.1890334944, green: 0.189160884, blue: 0.2188395332, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.1450127661, green: 0.1447194815, blue: 0.1654368043, alpha: 1)
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            guard let updateShoppingList = self.storyboard?.instantiateViewController(identifier: "AddShoppingListViewController") as? AddShoppingListViewController else { return }
            let listToUpdate = self.fetchedResultsController.object(at: indexPath)
            updateShoppingList.shoppingList = listToUpdate
            updateShoppingList.dataController = self.dataController
            updateShoppingList.indexPath = indexPath
            self.present(updateShoppingList, animated: true) {
                completion(true)
            }
        }
        updateAction.backgroundColor = #colorLiteral(red: 0.1890334944, green: 0.189160884, blue: 0.2188395332, alpha: 1)
        updateAction.backgroundColor = #colorLiteral(red: 0.1450127661, green: 0.1447194815, blue: 0.1654368043, alpha: 1)
        updateAction.image = UIImage(systemName: "pencil.circle")
        updateAction.image = UIGraphicsImageRenderer(size: CGSize(width: 35, height: 35)).image { _ in
            UIImage(systemName: "pencil.circle")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
        }
        updateAction.image = updateAction.image?.colored(in: .white)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let list = self.fetchedResultsController.object(at: indexPath)
        let alertAction = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            list.reminderSwitch = !list.reminderSwitch
            guard let self = self else { return }
            do {
                try self.dataController.viewContext.save()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } catch let error {
                debugPrint(error)
            }
            completion(true)
        }
        if list.reminderSwitch {
            alertAction.image = UIImage(systemName: "bell.slash.fill")
        } else {
            alertAction.image = UIImage(systemName: "bell.fill")
        }
        alertAction.backgroundColor = #colorLiteral(red: 0.1890334944, green: 0.189160884, blue: 0.2188395332, alpha: 1)
        alertAction.backgroundColor = #colorLiteral(red: 0.1450127661, green: 0.1447194815, blue: 0.1654368043, alpha: 1)
        let configuration = UISwipeActionsConfiguration(actions: [alertAction])
        return configuration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddShoppingList" {
            guard let destination = segue.destination as? AddShoppingListViewController else { return  }
            destination.dataController = dataController
        } else if segue.identifier == "Categories" {
            guard let destination = segue.destination as? CategoriesViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.dataController = self.dataController
            destination.shoppingList = fetchedResultsController.object(at: indexPath)
        }
    }
}
