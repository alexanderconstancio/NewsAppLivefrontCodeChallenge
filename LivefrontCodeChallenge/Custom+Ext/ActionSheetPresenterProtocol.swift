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
    func presentActionSheet(sheet: UIActivityViewController)
    func showCopyToClipAlert()
    func dateRangeSelected(range: Int)
}
