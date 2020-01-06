//
//  CardViewController.swift
//  GoExploreApp
//
//  Created by Takasur Azeem on 02/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    let allIcons = [#imageLiteral(resourceName: "001-yogurt.png"),#imageLiteral(resourceName: "002-watermelon.png"),#imageLiteral(resourceName: "003-water-bottle.png"),#imageLiteral(resourceName: "004-tomato.png"),#imageLiteral(resourceName: "005-tea-bag.png"),#imageLiteral(resourceName: "006-sparkling-drink.png"),#imageLiteral(resourceName: "007-spaguetti.png"),#imageLiteral(resourceName: "008-cream.png"),#imageLiteral(resourceName: "009-snack.png"),#imageLiteral(resourceName: "011-seasoning.png"),#imageLiteral(resourceName: "012-sauce.png")]
    
    let suggestedIcons = [#imageLiteral(resourceName: "001-yogurt.png"),#imageLiteral(resourceName: "002-watermelon.png"),#imageLiteral(resourceName: "003-water-bottle.png"),#imageLiteral(resourceName: "004-tomato.png"),#imageLiteral(resourceName: "005-tea-bag.png"),#imageLiteral(resourceName: "006-sparkling-drink.png"),#imageLiteral(resourceName: "007-spaguetti.png"),#imageLiteral(resourceName: "008-cream.png"),#imageLiteral(resourceName: "009-snack.png"),#imageLiteral(resourceName: "011-seasoning.png"),#imageLiteral(resourceName: "012-sauce.png")]
    
    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var itemNameTextField: UITextField! {
        didSet {
            itemNameTextField.delegate = self
            itemNameTextField.addTarget(self, action: #selector(AddCategoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    @IBOutlet weak var suggestedIconsCollectionView: UICollectionView! {
        didSet {
            allIconsCollectionView.delegate = self
            allIconsCollectionView.dataSource = self
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
        itemNameTextField.attributedPlaceholder =
            NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        suggestionHeightConstraint.constant = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allIconsCollectionView.register(UINib(nibName: "AllIconsCell", bundle: nil), forCellWithReuseIdentifier: "AllIconsCell")
        allIconsCollectionView.register(UINib(nibName: "AllIconsSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AllIconsSectionHeader")
        
        suggestedIconsCollectionView.register(UINib(nibName: "SuggestedIconsCell", bundle: nil), forCellWithReuseIdentifier: "suggestedIconsCell")
        suggestedIconsCollectionView.register(UINib(nibName: "SuggestedIconsSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SuggestedIconsSectionHeader")
    }
    
}
