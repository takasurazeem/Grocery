//
//  ShoppingLists.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation

struct _ShoppingLists {
    let name: String
    let dateAdded: Date
    let categoriesInList: Int
    let remindOn: Date
    let reminderSwitch: Bool
    
    static var generatedDummyLists : [_ShoppingLists] = {
        return [
        _ShoppingLists(name: "Monthly Shopping for home 🏠", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceReferenceDate), categoriesInList: 15, remindOn: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), reminderSwitch: true),
        _ShoppingLists(name: "Monthly Shopping hostel", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceReferenceDate), categoriesInList: 0, remindOn: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), reminderSwitch: false),
        _ShoppingLists(name: "Monthly Shopping office 💼", dateAdded: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceReferenceDate), categoriesInList: 2, remindOn: Date(timeIntervalSinceNow: Date.init().timeIntervalSinceNow), reminderSwitch: true)
        ]
    }()
}
