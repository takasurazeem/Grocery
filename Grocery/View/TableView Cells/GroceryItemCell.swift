//
//  GroceryItemCell.swift
//  Grocery
//
//  Created by Takasur Azeem on 05/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class GroceryItemCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var completedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(item: GroceryItem) {
        let quantity = item.quantity!.doubleValue
        let text = quantity == 0 ? item.name! : "\(item.quantity!) \(item.unit!) \(item.name!)"
        itemName.text = text
        completedIcon.image = UIImage(named: "circle-shape-outline")!
        
        if item.completed {
            completedIcon.image = #imageLiteral(resourceName: "check-mark.png")
            let color = #colorLiteral(red: 0.8879938472, green: 0.8879938472, blue: 0.8879938472, alpha: 1)
            itemName.textColor = color
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
            let range = NSMakeRange(0, attributeString.length)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: range)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), range: range)
            itemName.attributedText = attributeString
        }
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if selected {
//            print("Selected")
//        } else {
//            print("Deselected")
//        }
//    }

}
