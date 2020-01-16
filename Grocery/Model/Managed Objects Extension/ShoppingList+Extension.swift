//
//  ShoppingList+Extension.swift
//  Grocery
//
//  Created by Takasur Azeem on 16/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingList {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
