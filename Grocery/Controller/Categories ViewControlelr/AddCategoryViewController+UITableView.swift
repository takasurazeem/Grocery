//
//  AddCategoryViewController+UITableView.swift
//  Grocery
//
//  Created by Takasur Azeem on 05/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension CategoriesViewController : UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! GroceryCategoryCell
        
        cell.setup(item: categories[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShoppingList", sender: self)
    }
    
    //
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    ////        let completed =
    //    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO:- Complete it
    }
}
