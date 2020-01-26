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
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var textFieldQuantity: DateTextField!
    @IBOutlet weak var textFieldUnit: DateTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}
