//
//  AddShoppingListViewController+Extension.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension AddShoppingListViewController : UITextFieldDelegate {
    
    func setupDatePicker() {
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.minimumDate = Date()
        remindOnTextField.text = "\(datePicker.date.toString(dateFormat: dateFormat))"
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        remindOnTextField.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        doneButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        remindOnTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func datePickerDone() {
        remindOnTextField.resignFirstResponder()
    }
    
    @objc func dateChanged() {
        remindOnTextField.text = "\(datePicker.date.toString(dateFormat: dateFormat))"
    }
    
}
