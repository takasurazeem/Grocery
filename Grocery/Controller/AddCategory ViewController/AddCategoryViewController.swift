//
//  CardViewController.swift
//  GoExploreApp
//
//  Created by Takasur Azeem on 02/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    
    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var itemNameTextField: UITextField! {
        didSet {
            itemNameTextField.delegate = self
            itemNameTextField.addTarget(self, action: #selector(AddCategoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        }
    }
    @IBOutlet weak var suggestedIconsCollectionView: UICollectionView!
    @IBOutlet weak var suggestionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var allIconsCollectionView: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        itemNameTextField.attributedPlaceholder =
            NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        suggestionHeightConstraint.constant = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
