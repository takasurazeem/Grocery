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
                self.transform = .init(scaleX: 1.3, y: 1.3)
                self.image.animateCircle(with: 0.2, selected: true)
            } else {
                self.transform = .identity
                self.image.animateCircle(with: 0.2, selected: false)
            }
        }
    }
}
