//
//  ReloadHomePageProtocol.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation

/// Activates skeleton loading views for the top article cell
protocol ReloadNewArticlesDelegate: AnyObject {
    func ActivateCellSkeletonView()
}

/// Activates skeleton loading views for the basic article cell
protocol ReloadBasicArticlesDelegate: AnyObject {
    func ActivateCellSkeletonView()
}
