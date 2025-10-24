//
//  JournalModel.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//

import Foundation

struct Journal: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date = .now
    var isBookmarked: Bool = false
}

extension Date {
    var pretty: String {
        let f = DateFormatter()
        f.calendar  = Calendar(identifier: .gregorian)
        f.locale    = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "dd/MM/yyyy"
        return f.string(from: self)
    }
}
