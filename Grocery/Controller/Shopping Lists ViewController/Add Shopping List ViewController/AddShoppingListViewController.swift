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
    @IBOutlet weak var shoppingListItemTextField: UITextField!
    
    
    var datePicker : UIDatePicker!
    let dateFormat = "dd/MM/yyyy h:mm a"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatePicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listName.becomeFirstResponder()
    }
    
    @IBAction func doneButtonPressedListItem(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
}
