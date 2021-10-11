//
//  CustomDropdown.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/9/21.
//

import Foundation
import DropDown

/// Custom dropdown object with my settings
class CellMenuDropdown: DropDown {
    
    /// provide an array of option strings and a button to anchor to. Will return a custom dropdown menu
    func setupCustomDropdown(options: [String], anchorButton: UIButton) {
        cornerRadius = 10
        backgroundColor = .systemGray6
        textColor = .systemGray
        selectionBackgroundColor = .systemGray5
        selectedTextColor = .systemGray
        width = 150
        
        dataSource = options
        anchorView = anchorButton
    }
}
