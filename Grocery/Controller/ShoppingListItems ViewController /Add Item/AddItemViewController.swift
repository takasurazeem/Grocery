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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupQuantityPicker()
        updateItemButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func btnAddPressed(_ sender: UIButton) {
        if createItem() {
            save()
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
    
    func reset() {
        itemNameTextfield.text = ""
        quantityTextField.text = "0"
        
    }
    
    func createItem() -> Bool {
        let item = GroceryItem(context: dataController.viewContext)
        guard let name = itemNameTextfield.text else {
            showAlert(with: "", message: "Please enter item name", style: .alert)
            return false
        }
        item.name = name
        item.category = itemCategory
        if let quantity = quantityTextField.text, !quantity.isEmpty {
            item.quantity = NSDecimalNumber(string: quantity)
        } else {
            showAlert(with: "", message: "Please enter a quantity", style: .alert)
            return  false
        }
        item.unit = unitTextField.text
        return true
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
    
    @objc func quantityPickerDone() {
        unitTextField.resignFirstResponder()
    }
    
}
