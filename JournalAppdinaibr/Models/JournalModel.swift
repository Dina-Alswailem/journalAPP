//
//  JournalModel.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//

import Foundation

// The main data model representing a single journal entry
struct Journal: Identifiable, Equatable {
    // A unique ID for each journal (used for SwiftUI lists and identification)
    let id = UUID()
    // The title of the journal entry
    var title: String
    // The main text content of the journal
    var content: String
    // The creation or modification date (default is current date)
    var date: Date = .now
    // A flag indicating whether the journal is bookmarked
    var isBookmarked: Bool = false
}

// Extends the Date type to add a formatted string version
extension Date {
    // Returns a date string formatted as "dd/MM/yyyy"
    var pretty: String {
        // Creates a DateFormatter instance for formatting dates
        let f = DateFormatter()
        // Sets the calendar to Gregorian
        f.calendar  = Calendar(identifier: .gregorian)
        // Ensures consistent English formatting with Western digits
        f.locale    = Locale(identifier: "en_US_POSIX")
        // Sets the desired date format (day/month/year)
        f.dateFormat = "dd/MM/yyyy"
        // Converts the date object to a formatted string
        return f.string(from: self)
    }
}
