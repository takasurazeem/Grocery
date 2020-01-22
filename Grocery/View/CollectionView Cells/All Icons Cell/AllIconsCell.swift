//
//  AllIconsCell.swift
//  Grocery
//
//  Created by Takasur Azeem on 07/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

class AllIconsCell: UICollectionViewCell {

    @IBOutlet weak var image: CategoryImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = image.frame.height / 2
    }

    
    
    func setup(imageWith name: String) {
        image.image = UIImage(named: name)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
//                self.image.layer.borderColor = UIColor.init(white: 1, alpha: 1).cgColor
//                self.image.animateBorderWidth(toValue: 2, duration: 0.2)
                self.image.animateCircle(with: 0.2, selected: true)
            } else {
                self.image.animateCircle(with: 0.2, selected: false)
            }
        }
    }
}
