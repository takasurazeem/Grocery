//
//  DateTextField.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class DateTextField: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action != #selector(UIResponderStandardEditActions.copy(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
