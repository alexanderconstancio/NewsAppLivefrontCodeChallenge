//
//  ActionSheetPresenterProtocol.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/9/21.
//

import Foundation
import UIKit

/// Provides instructions for article cell menu option functions
protocol ActionSheetPresenterDelegate: AnyObject {
    /// Presents action sheet for sharing article url
    func presentActionSheet(forSheet: UIActivityViewController)
    
    /// Presents an alert controller from the homeViewController for copied to clipboard alert
    func showCopyToClipAlert()
    
    /// Activates method from homeViewController inside of the cell and reloads the articles with a new time range
    func dateRangeSelected(inRange: Int)
}
