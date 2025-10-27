//
//  Panel.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//

import SwiftUI

// Defines a reusable container view called Panel that accepts any SwiftUI content
struct Panel<Content: View>: View {
    // Holds the content passed to the Panel
    let content: Content

    // Custom initializer that uses a ViewBuilder closure to provide the content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    // Describes the layout and appearance of the Panel
    var body: some View {
        // A ZStack allows layering views on top of each other
        ZStack {
            // Adds a semi-transparent black background covering the entire screen
            Color.black.opacity(0.85).ignoresSafeArea()

            // Places the passed content inside a vertical stack
            VStack { content }
                // Adds padding inside the panel
                .padding(16)
                // Adds a rounded rectangular background with a dark gray fill color
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color(red: 24/255, green: 24/255, blue: 24/255))
                )
                // Adds a subtle white border overlay with low opacity
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
                // Adds extra horizontal and vertical padding around the panel
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .padding(.bottom, 20)
                // Ensures the panel stays visible even when the keyboard appears
                .ignoresSafeArea(.keyboard)
        }
    }
}
