//
//  Ext-HomeCVActionSheetDelegate.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/9/21.
//

import Foundation
import UIKit

extension HomeViewController: ActionSheetPresenterDelegate {
    
    // Handle logic for new article timeframe 
    func dateRangeSelected(inRange: Int) {
        reloadArticleCellsDelegate?.activateCellSkeletonView()
        
        reloadBasicArticleCellsDelegate.forEach { delegate in
            delegate.activateCellSkeletonView()
        }
        
        fetchArticleDataWith(timeFrame: inRange)
        
        // Set the current page title based on the range entered 
        if inRange == 1 {
            currentPageIndexTitle = "Trending Today"
            popularArticlesIndexNumber = 1
        } else if inRange == 7 {
            currentPageIndexTitle = "Trending this Week"
            popularArticlesIndexNumber = 7
        } else {
            currentPageIndexTitle = "Trending Last 30 Days"
            popularArticlesIndexNumber = 30
        }
    }
    
    func showCopyToClipAlert() {
        let alert = UIAlertController(title: "Copied to clipboard", message: "", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func presentActionSheet(forSheet: UIActivityViewController) {
        present(forSheet, animated: true)
    }
}
