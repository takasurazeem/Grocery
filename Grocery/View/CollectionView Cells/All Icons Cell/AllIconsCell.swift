//
//  AllIconsCell.swift
//  Grocery
//
//  Created by Takasur Azeem on 07/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AllIconsCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(imageWith name: String) {
        image.image = UIImage(named: name)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
            } else {
                self.backgroundColor = .clear
            }
        }
    }
}
