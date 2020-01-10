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
    let remindOn: Date
    let reminderSwitch: Bool
    
    static var generatedDummyLists : [ShoppingList] = {
        return [
        ShoppingList(name: "Monthly Shopping for home 🏠", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceReferenceDate), categoriesInList: 15, remindOn: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), reminderSwitch: true),
        ShoppingList(name: "Monthly Shopping hostel", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceReferenceDate), categoriesInList: 0, remindOn: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), reminderSwitch: false),
        ShoppingList(name: "Monthly Shopping office 💼", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceReferenceDate), categoriesInList: 2, remindOn: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), reminderSwitch: true)
        ]
    }()
}
