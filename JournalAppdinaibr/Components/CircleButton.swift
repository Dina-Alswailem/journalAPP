//
//  CircleButton.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//

import SwiftUI

// Defines a new SwiftUI view called CircleButton
struct CircleButton: View {
    // The system icon name (SF Symbol) to be shown inside the button
    let symbol: String
    // The color of the icon (foreground color)
    let fg: Color
    // The background color of the circular shape
    let bg: Color
    // The action (function) that runs when the button is pressed
    var action: () -> Void

    // The main body that describes how the view looks and behaves
    var body: some View {
        // Creates a button that triggers the given action when tapped
        Button(action: action) {
            // Displays a system image (SF Symbol) inside the button
            Image(systemName: symbol)
                // Sets the font size and weight of the symbol
                .font(.system(size: 16, weight: .semibold))
                // Sets the color of the symbol
                .foregroundColor(fg)
                // Adds padding around the image
                .padding(12)
                // Adds a circular colored background using the 'bg' color
                .background(bg, in: Circle())
        }
        // Removes the default button style for a cleaner appearance
        .buttonStyle(.plain)
    }
}
