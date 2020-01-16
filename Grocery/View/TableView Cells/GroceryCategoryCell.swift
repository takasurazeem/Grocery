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

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var remainingCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.layer.cornerRadius = itemName.frame.height / 2
        remainingCount.layer.backgroundColor  = UIColor.white.cgColor
        remainingCount.layer.cornerRadius = remainingCount.frame.height / 3
    }
    
    func setup(item: _GroceryCategory) {
        itemImage.image = item.image
        itemName.text = item.name
        itemName.textColor = .white
        remainingCount.text = "\(item.itemsCount)"
        
        
        if item.itemsCount == 0 {
            let color = #colorLiteral(red: 0.3624763489, green: 0.3624763489, blue: 0.3624763489, alpha: 1)
            remainingCount.layer.backgroundColor  = color.cgColor
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
