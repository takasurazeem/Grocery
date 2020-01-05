//
//  ViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 03/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit



class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let categories = GroceryCategory.getDummyCategories()
    let cellIdentifier = "Cell"
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController: AddCategoryViewController!
    var visualEffectView : UIVisualEffectView!
    
    let cardHeight: CGFloat = 600
    let cardHandlerAreaHeight: CGFloat = 65
    
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterupted: CGFloat = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        // IMPORTANT!!!
        visualEffectView.isUserInteractionEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
    }
    
    @IBAction func btnAddCategoryPressed(_ sender: UIButton) {
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
        // IMPORTANT!!!
        visualEffectView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoppingList" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category = categories[indexPath.row]
            guard let destination = segue.destination as? ShoppingListViewController else { return }
            destination.title = category.name
        }
    }
    
}

