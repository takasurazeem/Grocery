//
//  AddShoppingListProtocol.swift
//  Grocery
//
//  Created by Takasur Azeem on 13/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation

protocol AddShoppingListProtocol {
    func add(list: ShoppingList)
    func update(at indexPath: IndexPath?)
}
