//
//  AllIconsSectionHeader.swift
//  Grocery
//
//  Created by Takasur Azeem on 07/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AllIconsSectionHeader: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    func setup(label with: String) {
        title.text = with
    }
}
