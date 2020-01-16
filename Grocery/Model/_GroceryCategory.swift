//
//  GroceryCategories.swift
//  Grocery
//
//  Created by Takasur Azeem on 04/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation
import UIKit

struct _GroceryCategory {
    let name: String
    let image: UIImage
    let itemsCount: Int
    
    static func getFoodIcons() -> Images? {
        
        guard let fileURL = Bundle.main.url(forResource: "images", withExtension: "json") else {
            print("couldn't find the file")
            return nil
        }
        do {
            let content = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let images = try! decoder.decode(Images.self, from: content)
            return images
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func getDummyCategories() -> [_GroceryCategory] {
        return [
        .init(name: "Bakery", image: #imageLiteral(resourceName: "046-bread-1.png"), itemsCount: 2),
        .init(name: "Fruits and Vegetables", image: #imageLiteral(resourceName: "041-carrot"), itemsCount: 10),
        .init(name: "Meat and Poultry", image: #imageLiteral(resourceName: "016-chicken-leg"), itemsCount: 1),
        .init(name: "Dairy and Egg", image: #imageLiteral(resourceName: "034-eggs"), itemsCount: 0),
        .init(name: "Snacks", image: #imageLiteral(resourceName: "009-snack"), itemsCount: 0),
        .init(name: "Household", image: #imageLiteral(resourceName: "031-flour.png"), itemsCount: 7),
        .init(name: "Milk", image: #imageLiteral(resourceName: "023-milk-bottle"), itemsCount: 2),
        .init(name: "Soda", image: #imageLiteral(resourceName: "043-can"), itemsCount: 2),
        .init(name: "Peanuts", image: #imageLiteral(resourceName: "038-toffee"), itemsCount: 2),
        .init(name: "Cookies", image: #imageLiteral(resourceName: "037-cookie"), itemsCount: 2)
        ]
    }
}

struct Images: Codable {
    let food: [String]
    let hardware: [String]
}
