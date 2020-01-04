//
//  RootViewController.swift
//  Grocery
//
//  Created by Takasur Azeem on 04/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.barStyle = .black
        let backImage = UIImage(systemName: "arrow.left")
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
