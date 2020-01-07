//
//  AddCategory+SuggestedItemCollectionView.swift
//  Grocery
//
//  Created by Takasur Azeem on 06/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension AddCategoryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView.viewWithTag(1001) {
            return allIcons?.foods.count ?? 0
        } else {
            return suggestedIcons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView.viewWithTag(1001) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllIconsCell", for: indexPath) as! AllIconsCell
            
            let imageName = allIcons?.foods[indexPath.row]
            cell.setup(imageWith: imageName ?? "")
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedIconsCell", for: indexPath) as! SuggestedIconsCell
        
        cell.setup(icon: suggestedIcons[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            if collectionView == collectionView.viewWithTag(1001){
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AllIconsSectionHeader", for: indexPath) as! AllIconsSectionHeader
                headerView.setup(label: "All Icons")
                return headerView
            } else {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SuggestedIconsSectionHeader", for: indexPath) as! SuggestedIconsSectionHeader
                headerView.setup(title: "Suggested Icons")
                
                return headerView
            }
        }
        fatalError()
    }
    
}
