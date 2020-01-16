//
//  CardViewController.swift
//  GoExploreApp
//
//  Created by Takasur Azeem on 02/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    let allIcons = _GroceryCategory.getFoodIcons()!
    let sectionTitles = ["Foods", "Hardwares"]
    var icons: [Int: [String]] = [:]
    
    var suggestedIcons : [UIImage] = []
    
    
    @IBOutlet weak var itemNameTextField: UITextField! {
        didSet {
            itemNameTextField.delegate = self
            itemNameTextField.addTarget(self, action: #selector(AddCategoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        suggestionHeightConstraint.constant = 0
        icons = [0 : allIcons.food, 1 : allIcons.hardware]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let columnLayout = ColumnFlowLayout(
//            cellsPerRow: 5,
//            minimumInteritemSpacing: 10,
//            minimumLineSpacing: 10,
//            sectionInset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        )
        
        // MARK:- Register All Icons Cells
        allIconsCollectionView.register(UINib(nibName: "AllIconsCell", bundle: nil), forCellWithReuseIdentifier: "AllIconsCell")
        allIconsCollectionView.register(UINib(nibName: "AllIconsSectionHeader", bundle: nil), forSupplementaryViewOfKind:
            UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AllIconsSectionHeader")
//        allIconsCollectionView.collectionViewLayout = columnLayout
        // MARK:- Register Suggested Icons Cells
        suggestedIconsCollectionView.register(UINib(nibName: "SuggestedIconsCell", bundle: nil), forCellWithReuseIdentifier: "suggestedIconsCell")
        suggestedIconsCollectionView.register(UINib(nibName: "SuggestedIconsSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SuggestedIconsSectionHeader")
        
    }
}
