//
//  Ext-HomeTVDelegate.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/5/21.
//

import Foundation
import UIKit

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
        // This call is only relevent when the page is reloaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                topCell.hideAnimation()
                basicCell.hideAnimation()
            }
            
            if indexPath.item == 0 {
                reloadArticleCellsDelegate = topCell
                topCell.articleViewModel = articleViewModel
                
                // remove initial spinner from parent views
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
            return CGSize(width: view.frame.width - 20, height: 500)
        }
        
        // this logic returns the basic cells layout side by side
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size - 10, height: size + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articleBodyVC = ArticleBodyViewController()
        let articleViewModel = articleViewModels[indexPath.item]
        articleBodyVC.article = articleViewModel
        
        self.present(articleBodyVC, animated: true)
    }
}


