//
//  GroceryItems.swift
//  Grocery
//
//  Created by Takasur Azeem on 04/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation

struct _GroceryItems {
    let name: String
    let quantity: Int
    let completed: Bool
    
    static func getGroceryItems() -> [_GroceryItems] {
        return [
            .init(name: "ripe avos", quantity: 2, completed: false),
            .init(name: "Apples", quantity: 1, completed: true),
            .init(name: "Oranges", quantity: 2, completed: true),
            .init(name: "Pineapple", quantity: 1, completed: false),
            .init(name: "Bunch of corriander", quantity: 1, completed: false),
            .init(name: "Watermelon", quantity: 1, completed: false),
            .init(name: "Lime", quantity: 2, completed: false),
        ]
    }
}
