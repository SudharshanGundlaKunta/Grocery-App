//
//  StringExtension.swift
//  Grocery
//
//  Created by Apple on 22/08/24.
//

import Foundation

extension String {
    
    var convertToDate: String {
        var dateString = self
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = formatter.date(from: dateString) else {
            return "date"
        }
        
        var dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateStyle = .medium
        
        return dateToStringFormatter.string(from: date)
    }
}
