//
//  DateExtension.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation

extension Date {
    
    // today.toString(dateFormat: "dd-MM")
    func toString(dateFormat format : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    // .short, .medium, .long, .full
    func toString(style: DateFormatter.Style) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = style
      return dateFormatter.string(from: self)
    }
}
