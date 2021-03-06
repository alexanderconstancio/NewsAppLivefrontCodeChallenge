//
//  Ext-HomeTVDelegate.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/5/21.
//

import Foundation
import UIKit

// UICollectionView delegate and dataSource functions
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: topArticleCellID, for: indexPath) as! TopArticleCell
        topCell.shareSheetDelegate = self
        
        let basicCell = collectionView.dequeueReusableCell(withReuseIdentifier: basicArticleCellID, for: indexPath) as! BasicArticleCell
        basicCell.shareSheetDelegate = self
        
        let articleViewModel = articleViewModels[indexPath.item]
        
        // Create a delay when hiding skeletonView animation.
        // This call is only relevant when the page is reloaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                topCell.hideAnimation()
                basicCell.hideAnimation()
            }
            
        // If the cell equals the first in the list, we return the large full sized featured article cell.
            if indexPath.item == 0 {
                reloadArticleCellsDelegate = topCell
                topCell.articleViewModel = articleViewModel
                topCell.timeFrameLabel.text = currentPageIndexTitle.rawValue
                
                // Remove initial spinner from parent views
                self.spinner.willMove(toParent: nil)
                self.spinner.view.removeFromSuperview()
                self.spinner.removeFromParent()
                
                return topCell
            } else {
                basicCell.articleViewModel = articleViewModel
                reloadBasicArticleCellsDelegate.append(basicCell)
            }
        
        return basicCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            // Return the first cells width as the frames width - 20 because we are adding
            // insets below to the collectionView. See insetForSectionAt below.
            return CGSize(width: view.frame.width - 20, height: 500)
        }
        
        // This logic returns the basic cells layout side by side
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size - 10, height: size + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Present the article body viewController when selected a cell
        // We provide the presented controller with an articleViewModel object
        let articleBodyVC = ArticleBodyViewController()
        let articleViewModel = articleViewModels[indexPath.item]
        articleBodyVC.article = articleViewModel
        self.present(articleBodyVC, animated: true)
    }
}
