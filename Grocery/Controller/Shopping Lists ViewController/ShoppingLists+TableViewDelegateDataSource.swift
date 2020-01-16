//
//  ShoppingLists+TableViewDelegateDataSourse.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension ShoppingListsViewController : UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingListsCell
        
        cell.setup(with: lists[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Categories", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            self.dataController.viewContext.delete(self.lists[indexPath.row])
            self.lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
        
//        deleteAction.image = UIImage(named: "delete")
//        deleteAction.image = UIImage(systemName: "trash")?.colored(in: #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
//        deleteAction.image = UIGraphicsImageRenderer(size: CGSize(width: 35, height: 35)).image { _ in
//            UIImage(systemName: "delete")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
//        }
//        deleteAction.image = deleteAction.image?.colored(in: .white)
        

        deleteAction.backgroundColor = #colorLiteral(red: 0.1890334944, green: 0.189160884, blue: 0.2188395332, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.1450127661, green: 0.1447194815, blue: 0.1654368043, alpha: 1)
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            guard let updateShoppingList = self.storyboard?.instantiateViewController(identifier: "AddShoppingListViewController") as? AddShoppingListViewController else { return }
            updateShoppingList.shoppingList = self.lists[indexPath.row]
            updateShoppingList.dataController = self.dataController
            updateShoppingList.delegate = self
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
        let list = self.lists[indexPath.row]
        
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
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: Complete it
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddShoppingList" {
            guard let destination = segue.destination as? AddShoppingListViewController else { return  }
            destination.dataController = dataController
            destination.delegate = self
        }
    }
}
