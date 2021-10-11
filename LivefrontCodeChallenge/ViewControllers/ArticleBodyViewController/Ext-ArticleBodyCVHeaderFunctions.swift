//
//  Ext-ArticleBodyCVHeaderFunctions.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

// Article body collectionView header delegate functions
extension ArticleBodyViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let homeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: bodyHeaderCellID, for: indexPath) as! ArticleBodyHeaderCell
        homeHeader.articleBodyViewModel = articleBodyViewModel
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
            
            let frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 400)
            let dummyCell = ArticleBodyHeaderCell(frame: frame)
            dummyCell.articleBodyViewModel = articleBodyViewModel
            dummyCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: collectionView.frame.width, height: 800)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            
            return CGSize(width: collectionView.frame.width, height: estimatedSize.height)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
