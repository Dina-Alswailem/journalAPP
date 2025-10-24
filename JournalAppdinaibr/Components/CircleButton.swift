//
//  CircleButton.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//

import SwiftUI

struct CircleButton: View {
    let symbol: String
    let fg: Color
    let bg: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(fg)
                .padding(12)
                .background(bg, in: Circle())
        }
        .buttonStyle(.plain)
    }
}
