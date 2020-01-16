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
    
    @IBOutlet weak var listName: UITextField!
    @IBOutlet weak var remindOn: UITextField!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var dataController: DataController!
    let defaults = UserDefaults.standard
    fileprivate let idKey = "shoppingListId"
    var id = 1
    
    var datePicker : UIDatePicker!
    let dateFormat = "dd/MM/yyyy h:mm a"
    
    var delegate : AddShoppingListProtocol?
    var shoppingList: ShoppingList?
    var indexPath: IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatePicker()
        if let shoppingList = shoppingList {
            btnAdd.isHidden = true
            listName.text = shoppingList.name
            remindOn.text = shoppingList.remindOn?.toString(dateFormat: dateFormat)
            reminderSwitch.isOn = shoppingList.reminderSwitch
        } else {
            btnUpdate.isHidden = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listName.becomeFirstResponder()
    }
    
    @IBAction func doneButtonPressedListItem(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func saveShoppingList(_ sender: UIButton) {
        id = defaults.value(forKey: idKey) as? Int ?? 1
        let context = dataController.viewContext
        let shoppingList = ShoppingList(context: context)
        shoppingList.id = Int64(id)
        shoppingList.name = listName.text
//        shoppingList.creationDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let dateString = remindOn.text {
            shoppingList.remindOn = dateFormatter.date(from: dateString)
        }
        shoppingList.reminderSwitch = reminderSwitch.isOn
        do {
            try context.save()
        } catch let error {
            debugPrint(error)
        }
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.defaults.set(self.id + 1, forKey: self.idKey)
            self.delegate?.add(list: shoppingList)
        }
    }
    
    @IBAction func updateList(_ sender: UIButton) {
        let context = dataController.viewContext
        shoppingList?.name = listName.text
//        shoppingList?.creationDate = shoppingList?.creationDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let dateString = remindOn.text {
            shoppingList?.remindOn = dateFormatter.date(from: dateString)
        }
        shoppingList?.reminderSwitch = reminderSwitch.isOn
        do {
            try context.save()
        } catch let error {
            debugPrint(error)
        }
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.update(at: self.indexPath)
        }
    }
}
