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
    func dateRangeSelected(inRange: NYT_APITimeframes) {
        reloadArticleCellsDelegate?.activateCellSkeletonView()
        
        reloadBasicArticleCellsDelegate.forEach { delegate in
            delegate.activateCellSkeletonView()
        }
        
        fetchArticleDataWith(timeFrame: inRange)
        
        // Set the current page title based on the range entered 
        if inRange == .today {
            currentPageIndexTitle = .trendingToday
            articleAPIReturnRange = .today
        } else if inRange == .thisWeek {
            currentPageIndexTitle = .trendingThisWeek
            articleAPIReturnRange = .thisWeek
        } else {
            currentPageIndexTitle = .trendingThisMonth
            articleAPIReturnRange = .thisMonth
        }
    }
    
    // Presents alert controller showing that we have successfully copied to clipboard 
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
