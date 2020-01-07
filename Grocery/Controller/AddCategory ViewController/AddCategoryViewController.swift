//
//  CardViewController.swift
//  GoExploreApp
//
//  Created by Takasur Azeem on 02/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    var allIcons = GroceryCategory.getFoodIcons()
    
    var suggestedIcons : [UIImage] = []
    
    @IBOutlet weak var handleArea: UIView!
    
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
        itemNameTextField.attributedPlaceholder =
            NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        suggestionHeightConstraint.constant = 0
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
        
        
        /*
         let fileManager = FileManager.default
         let bundleURL = Bundle.main.bundleURL
         let assetURL = bundleURL.appendingPathComponent("Foods.bundle")
         do {
         let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
         
         for item in contents
         {
         print(item.lastPathComponent)
         if let image = UIImage(contentsOfFile: item.path) {
         allIcons.append(image)
         }
         }
         }
         catch let error as NSError {
         print(error)
         }
         suggestedIcons = allIcons
         */
    }
}
