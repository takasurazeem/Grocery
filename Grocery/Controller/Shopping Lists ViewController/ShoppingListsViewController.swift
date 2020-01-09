//
//  ShoppingListsViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class ShoppingListsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "ShoppingListsCell"
    let lists = ShoppingList.generatedDummyLists
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
