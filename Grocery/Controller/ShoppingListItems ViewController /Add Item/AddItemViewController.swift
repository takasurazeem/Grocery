//
//  AddItemViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 25/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateItemButton: UIButton!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var itemNameTextfield: UITextField!
    @IBOutlet weak var quantityTextField: DateTextField!
    @IBOutlet weak var unitTextField: DateTextField!
    
    var dataController: DataController!
    var itemCategory: GroceryCategory!
    var quantityPicker: UIPickerView!
    
    var itemToUpdate: GroceryItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupQuantityPicker()
        updateItemButton.isHidden = true
        
        if let item = itemToUpdate {
            titleLabel.text = "Update Item"
            
            itemNameTextfield.text = item.name
            quantityTextField.text = "\(item.quantity!)"
            unitTextField.text = item.unit
            
            addItemButton.isHidden = true
            updateItemButton.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if validate() {
            createItem()
            save()
        }
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        if validate() {
            updateItem()
            save()
            self.dismiss(animated: true, completion: nil)
        }
    }
    func save() {
        do {
            try dataController.viewContext.save()
            reset()
        } catch let error {
            debugPrint("Error: \(error)")
        }
    }
    
    func updateItem() {
        guard let item = itemToUpdate else { return }
        item.unit = unitTextField.text
        item.name = itemNameTextfield.text
        item.quantity = NSDecimalNumber(string: quantityTextField.text!)
    }
    
    func reset() {
        itemNameTextfield.text = ""
        itemNameTextfield.becomeFirstResponder()
        quantityTextField.text = "1"
        
    }
    
    func validate() -> Bool {
        guard itemNameTextfield.text != nil else {
            showAlert(with: "", message: "Please enter item name", style: .alert)
            return false
        }
        
        guard itemNameTextfield.text != nil else {
            showAlert(with: "", message: "Please enter a quantity", style: .alert)
            return  false
        }
        return true
    }
    
    func createItem() {
        let item = GroceryItem(context: dataController.viewContext)
        item.unit = unitTextField.text
        item.name = itemNameTextfield.text
        item.category = itemCategory
        item.quantity = NSDecimalNumber(string: quantityTextField.text!)
    }
    
    
    
    var quantities = ["kg", "grams", "size", "pc", "liter"]
    
}

extension AddItemViewController : UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func setupQuantityPicker() {
        quantityPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        quantityPicker.delegate = self
        quantityPicker.dataSource = self
        
        unitTextField.text = quantities[0]
        unitTextField.inputView = quantityPicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.quantityPickerDone))
        doneButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        unitTextField.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quantities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unitTextField.text = quantities[row]
    }
    
    @objc func quantityPickerDone() {
        unitTextField.resignFirstResponder()
    }
}
