//
//  ShoppingListsCell.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class ShoppingListsCell: UITableViewCell {

    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var categoriesInList: UILabel!
    @IBOutlet weak var reminderButton: UIButton!
    
    func setup(with item: ShoppingList) {
        listName.text = item.name
        dateCreated.text = item.dateAdded.toString(style: .medium)
        if item.categoriesInList > 0 {
            categoriesInList.text = "\(item.categoriesInList)"
        } else {
            categoriesInList.isHidden = true
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
