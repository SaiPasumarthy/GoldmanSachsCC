//
//  Date+Extension.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

extension Date {
    /// Gets the string of specified date
    func getStringForDate() -> String {
        return getDateFormatter().string(from: self)
    }
    
    /// Gets the current date in string format for the PDT TimeZone
    func getCurrentDateStringOfNASA() -> String {
        let dateFormatter = getDateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return dateFormatter.string(from: self)
    }
    
    private func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}


