//
//  UIDate_Ext.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/7/21.
//

import Foundation

extension Date {
    /// simple function that returns the day of the month number
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Date {
    /// simple extension that returns the full month name
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
