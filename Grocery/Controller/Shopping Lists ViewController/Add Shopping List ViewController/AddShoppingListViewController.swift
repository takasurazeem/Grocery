//
//  AddShoppingListViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddShoppingListViewController: UIViewController {
    
    @IBOutlet weak var listName: UITextField!
    @IBOutlet weak var remindOn: UITextField!
    
    
    var datePicker :UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
//        remindOn.text = datePicker.date.toString(style: .full)
        remindOn.text = "\(datePicker.date.toString(dateFormat: "dd/MM/yyyy h:mm a"))"
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        remindOn.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        remindOn.inputAccessoryView = toolBar
    }

    @objc func datePickerDone() {
        remindOn.resignFirstResponder()
    }

    @objc func dateChanged() {
        remindOn.text = "\(datePicker.date.toString(dateFormat: "dd/MM/yyyy h:mm a"))"
    }
    
}
