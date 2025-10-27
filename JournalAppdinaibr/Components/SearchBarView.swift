//
//  SearchBarView.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//

import SwiftUI

// A custom search bar view with a magnifying glass, text field, and microphone icon
struct SearchBarView: View {
    // A binding variable that connects the search text to external state
    @Binding var text: String
    // Accent color used for the text cursor and highlights
    var accent: Color

    // Describes the layout and style of the search bar
    var body: some View {
        // Horizontal stack to arrange icons and text field in a row
        HStack(spacing: 10) {
            // Magnifying glass icon on the left
            Image(systemName: "magnifyingglass")
                // Slightly transparent white color for the icon
                .foregroundColor(.white.opacity(0.7))
            
            // Search text field bound to the text variable
            TextField("Search", text: $text)
                // White text color
                .foregroundColor(.white)
                // Accent color for cursor and highlights
                .tint(accent)
            
            // Flexible space to push items apart
            Spacer(minLength: 0)
            
            // Microphone icon on the right
            Image(systemName: "mic.fill")
                // Slightly transparent white color for the mic icon
                .foregroundColor(.white.opacity(0.7))
        }
        // Adds horizontal padding inside the bar
        .padding(.horizontal, 16)
        // Adds vertical padding for height
        .padding(.vertical, 12)
        // Adds a blurred capsule background (Apple-style)
        .background(.ultraThinMaterial, in: Capsule())
        // Adds a subtle white stroke border around the capsule
        .overlay(Capsule().stroke(Color.white.opacity(0.08), lineWidth: 1))
        // Adds horizontal spacing from the screen edges
        .padding(.horizontal, 16)
        // Adds extra bottom padding for spacing
        .padding(.bottom, 30)
        // Adds soft shadow to lift the bar visually from the background
        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 8)
    }
}
