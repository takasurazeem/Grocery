//
//  GroceryItemCell.swift
//  Grocery
//
//  Created by Takasur Azeem on 04/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import QuartzCore


class GroceryCategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var remainingItemsCountInCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = categoryName.frame.height / 2
        remainingItemsCountInCategory.layer.backgroundColor  = UIColor.white.cgColor
        remainingItemsCountInCategory.layer.cornerRadius = remainingItemsCountInCategory.frame.height / 3
    }
    
    func setup(item: GroceryCategory) {
        categoryImage.image = UIImage(named: item.imageName!)
        categoryName.text = item.name
        categoryName.textColor = .white
        
        var notCompleted = 0
        if let items = item.groceryItems as? Set<GroceryItem> {
            items.forEach { (gItem) in
                if !gItem.completed {
                    notCompleted += 1
                }
            }
        }
        remainingItemsCountInCategory.text = "\(notCompleted)"
        remainingItemsCountInCategory.isHidden = item.groceryItems?.count == 0 || notCompleted == 0 ? true : false
        
        
        if notCompleted == 0 && item.groceryItems?.count != 0 {
            let color = #colorLiteral(red: 0.3624763489, green: 0.3624763489, blue: 0.3624763489, alpha: 1)
            remainingItemsCountInCategory.layer.backgroundColor  = color.cgColor
            categoryName.textColor = color
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.name!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.white, range: NSMakeRange(0, attributeString.length))
            categoryName.attributedText = attributeString
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
