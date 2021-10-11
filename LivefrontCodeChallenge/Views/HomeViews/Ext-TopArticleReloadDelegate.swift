//
//  TopArticleReloadDelegate.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

extension TopArticleCell: ReloadNewArticlesDelegate {
    
    func ActivateCellSkeletonView() {
        showSkeletonAnimation()
    }
}
