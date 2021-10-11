//
//  Ext-HomeCVActionSheetDelegate.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/9/21.
//

import Foundation
import UIKit

extension HomeViewController: ActionSheetPresenterDelegate {
    
    func dateRangeSelected(range: Int) {
        print(range)
        reloadArticleCellsDelegate?.ActivateCellSkeletonView()
        
        reloadBasicArticleCellsDelegate.forEach { delegate in
            delegate.ActivateCellSkeletonView()
        }
        
        fetchArticleDataWith(timeFrame: range)
    }
    
    func showCopyToClipAlert() {
        let alert = UIAlertController(title: "Copied to clipboard", message: "", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func presentActionSheet(sheet: UIActivityViewController) {
        
        present(sheet, animated: true)
    }
}
