//
//  SuggestedIconsCell.swift
//  Grocery
//
//  Created by Takasur Azeem on 07/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class SuggestedIconsCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(icon: UIImage) {
        image.image = icon
    }

}
