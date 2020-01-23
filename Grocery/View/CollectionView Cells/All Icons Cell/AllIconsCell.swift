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
    @IBOutlet weak var cellContentView: CategoryCellUIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = image.frame.height / 2
        cellContentView.layer.cornerRadius = cellContentView.frame.height / 2
    }
    
    
    
    func setup(imageWith name: String) {
        image.image = UIImage(named: name)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                //                self.image.animateCircle(with: 0.2, selected: true)
                cellContentView.animateCircle(with: 0.2, selected: true)
                self.image.transform = .init(scaleX: 0.8, y: 0.8)
            } else {
                self.image.transform = .identity
                cellContentView.animateCircle(with: 0.2, selected: false)
                //                self.image.animateCircle(with: 0.2, selected: false)
            }
        }
    }
}
