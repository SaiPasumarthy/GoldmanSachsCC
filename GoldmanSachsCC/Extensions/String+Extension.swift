//
//  String+Extension.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import Foundation

extension String {
    /// Gets the date for the given date string
    func getDateForString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}
