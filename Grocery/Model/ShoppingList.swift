//
//  ShoppingLists.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation

struct ShoppingList {
    let name: String
    let dateAdded: Date
    let categoriesInList: Int
    
    static var generatedDummyLists : [ShoppingList] = {
        return [
            ShoppingList(name: "Monthly Shopping", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), categoriesInList: 0)
        ]
    }()
}
