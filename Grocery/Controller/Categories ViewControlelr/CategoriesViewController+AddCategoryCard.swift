//
//  CategoriesViewController+AddCategoryCard.swift
//  Grocery
//
//  Created by Takasur Azeem on 05/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension CategoriesViewController {
    /**
     For : how would you go about adding scrollable content inside of the "card view". is it possible to move the y position of the card as the content scrolls?
     extension CardViewController: UIGestureRecognizerDelegate {
     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
     let offest = scrollView.contentOffset
     
     let v = (gestureRecognizer as! UIPanGestureRecognizer).velocity(in: nil)
     return v.y > abs(v.x) && offest.y <= 0
     }
     
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     
     return true
     }
     }
     */
}
