//
//  Ext-HomeCVHeaderFunctions.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/8/21.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let homeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! HomeHeaderCell
        let section = indexPath.section
        if kind == UICollectionView.elementKindSectionHeader {
            if section == 0 {
                return homeHeader
            } else {
               return UICollectionReusableView()
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 125)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
