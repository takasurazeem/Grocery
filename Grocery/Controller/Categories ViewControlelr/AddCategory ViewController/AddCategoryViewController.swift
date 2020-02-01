//
//  CardViewController.swift
//  GoExploreApp
//
//  Created by Takasur Azeem on 02/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var updateCategoryButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var itemNameTextField: UITextField! {
        didSet {
            itemNameTextField.delegate = self
            itemNameTextField.addTarget(self, action: #selector(AddCategoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            itemNameTextField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var suggestedIconsCollectionView: UICollectionView! {
        didSet {
            suggestedIconsCollectionView.delegate = self
            suggestedIconsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var suggestionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var allIconsCollectionView: UICollectionView! {
        didSet {
            allIconsCollectionView.delegate = self
            allIconsCollectionView.dataSource = self
        }
    }
    
    
    let allIcons = _GroceryCategory.getFoodIcons()!
    let sectionTitles = ["Foods", "Hardwares"]
    var icons: [Int: [String]] = [:]
    
    var suggestedIcons : [UIImage] = []
    var dataController: DataController!
    var shoppingList: ShoppingList!
    var category: GroceryCategory?
    
    override func viewWillAppear(_ animated: Bool) {
        suggestionHeightConstraint.constant = 0
        icons = [0 : allIcons.food, 1 : allIcons.hardware]
        if let category = category {
            addCategoryButton.isHidden = true
            updateCategoryButton.isHidden = false
            titleLabel.text = "Update Category"
            itemNameTextField.text = category.name
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnAddCategory(_ sender: UIButton) {
        guard let indexPath = allIconsCollectionView.indexPathsForSelectedItems?.first else {
            self.showAlert(with: "", message: "Please select an icon first", style: .alert)
            return
        }
        let imageName = icons[indexPath.section]![indexPath.row]
        if let name = itemNameTextField.text, !name.isEmpty {
            createCategory(name: name, imageName: imageName)
            save()
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self = self else { return }
                self.view.alpha = 0
            }) { [weak self]  completed in
                guard let self = self else { return }
                if completed {
                    UIView.animate(withDuration: 0.9) { [weak self] in
                        guard let self = self else { return }
                        self.view.alpha = 1
                    }
                }
            }
        } else {
            self.showAlert(with: "", message: "Please enter name for the category", style: .alert)
            return
        }
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        if let indexPath = allIconsCollectionView.indexPathsForSelectedItems?.first {
            let imageName = icons[indexPath.section]![indexPath.row]
            category?.imageName = imageName
        }
        if let name = itemNameTextField.text, !name.isEmpty {
            category?.name = name
            save()
            self.dismiss(animated: true, completion: nil)
        } else {
            self.showAlert(with: "", message: "Please enter name for the category", style: .alert)
            return
        }
    }
   
    func save() {
        do {
            try dataController.viewContext.save()
//            self.dismiss(animated: true, completion: nil)
        } catch let error {
            debugPrint(error)
        }
    }
    
    func createCategory(name: String, imageName: String) {
        let category = GroceryCategory(context: dataController.viewContext)
        category.name = name
        category.imageName = imageName
        category.shoppingList = self.shoppingList
    }
}
