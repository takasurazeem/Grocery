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
    @IBOutlet weak var dateRemind: UILabel!
    @IBOutlet weak var categoriesInList: UILabel!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var createdOnLabel: UILabel!
    
    
    fileprivate var reminderSwitch = false {
        didSet {
            if reminderSwitch {
                reminderButton.setImage(UIImage(systemName: "bell.circle.fill"), for: .normal)
            } else {
                reminderButton.setImage(UIImage(systemName: "bell.circle"), for: .normal)
            }
        }
    }
    
    func setup(with item: ShoppingList) {
        listName.text = item.name
        dateRemind.text = item.dateAdded.toString(dateFormat: "dd/MM/yyyy h:mm a")
        if item.categoriesInList > 0 {
            categoriesInList.text = "\(item.categoriesInList)"
            categoriesInList.alpha = 1
        } else {
            categoriesInList.alpha = 0
//            categoriesInList.isHidden = true
        }
        reminderSwitch = item.reminderSwitch
    }
    
    @IBAction func switchReminder(_ sender: UIButton) {
        reminderSwitch = !reminderSwitch
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoriesInList.layer.backgroundColor  = UIColor.white.cgColor
        categoriesInList.layer.cornerRadius = categoriesInList.frame.height / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
