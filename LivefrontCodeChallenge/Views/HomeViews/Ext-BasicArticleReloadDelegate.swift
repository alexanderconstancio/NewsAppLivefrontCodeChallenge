//
//  Ext-BasicArticleReloadDelegate.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

extension BasicArticleCell: ReloadBasicArticlesDelegate {
    
    // Hides skeleton views 
    func hideCellSkeletonView() {
        hideAnimation()
    }
    
    // Activates skeleton views through required function
    func activateCellSkeletonView() {
        showAnimatedSkeletonViews()
    }
}
