//
//  ListItem+Extension.swift
//  Grocery
//
//  Created by Takasur Azeem on 16/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation

extension GroceryItem {
    
    public override func awakeFromInsert() {
        creationDate = Date()
        completed = false
    }
    
}
