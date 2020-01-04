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

    func setup(item: GroceryItems) {
        itemName.text = item.quantity == 1 ? item.name : "\(item.quantity) \(item.name)"
        completedIcon.image = UIImage(named: "circle-shape-outline")!
        if item.completed {
            completedIcon.image = #imageLiteral(resourceName: "check-mark.png")
            let color = #colorLiteral(red: 0.3624763489, green: 0.3624763489, blue: 0.3624763489, alpha: 1)
            itemName.textColor = color
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.name)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.white, range: NSMakeRange(0, attributeString.length))
            itemName.attributedText = attributeString
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
