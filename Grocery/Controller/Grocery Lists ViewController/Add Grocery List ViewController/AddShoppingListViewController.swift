//
//  AddShoppingListViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 09/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit
import CoreData

class AddShoppingListViewController: UIViewController {
    
    @IBOutlet weak var listNameTextfField: UITextField!
    @IBOutlet weak var remindOnTextField: UITextField!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var addListButton: UIButton!
    @IBOutlet weak var updateListButton: UIButton!
    
    var dataController: DataController!
    fileprivate let idKey = "shoppingListId"
    
    var datePicker : UIDatePicker!
    let dateFormat = "dd/MM/yyyy h:mm a"
    
    var shoppingList: ShoppingList?
    var indexPath: IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatePicker()
        if let shoppingList = shoppingList {
            addListButton.isHidden = true
            listNameTextfField.text = shoppingList.name
            remindOnTextField.text = shoppingList.remindOn?.toString(dateFormat: dateFormat)
            reminderSwitch.isOn = shoppingList.reminderSwitch
        } else {
            updateListButton.isHidden = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        listNameTextfField.becomeFirstResponder()
    }
    
    @IBAction func doneButtonPressedListItem(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func saveShoppingList(_ sender: UIButton) {
        let context = dataController.viewContext
        let shoppingList = ShoppingList(context: context)
        shoppingList.name = listNameTextfField.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let dateString = remindOnTextField.text {
            shoppingList.remindOn = dateFormatter.date(from: dateString)
        }
        shoppingList.reminderSwitch = reminderSwitch.isOn
        do {
            try context.save()
        } catch let error {
            debugPrint(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateList(_ sender: UIButton) {
        let context = dataController.viewContext
        shoppingList?.name = listNameTextfField.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let dateString = remindOnTextField.text {
            shoppingList?.remindOn = dateFormatter.date(from: dateString)
        }
        shoppingList?.reminderSwitch = reminderSwitch.isOn
        do {
            try context.save()
        } catch let error {
            debugPrint(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
