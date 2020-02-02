//  AddCategoryViewController+UITableView.swift
//  Grocery
//
//  Created by Takasur Azeem on 05/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.


import UIKit

extension CategoriesViewController : UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! GroceryCategoryCell
        let category = fetchedResultsController.object(at: indexPath)
        cell.setup(item: category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShoppingList", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Update") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            let category = self.fetchedResultsController.object(at: indexPath)
            guard let editCategory = self.storyboard?.instantiateViewController(identifier: "AddCategoryViewController") as? AddCategoryViewController else { return }
            editCategory.category = category
            editCategory.dataController = self.dataController
            self.present(editCategory, animated: true, completion: nil)
            completion(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            let categoryToDelete = self.fetchedResultsController.object(at: indexPath)
            self.dataController.viewContext.delete(categoryToDelete)
            do {
                try self.dataController.viewContext.save()
            } catch let error {
                debugPrint(error)
            }
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
