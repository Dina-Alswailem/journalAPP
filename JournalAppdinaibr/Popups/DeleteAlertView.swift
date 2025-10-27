import SwiftUI

// A custom alert view for confirming delete actions
struct DeleteAlertView: View {
    // Title text displayed at the top of the alert
    let title: String
    // Message providing more details or warning text
    let message: String
    // Action to perform when the user cancels
    let onCancel: () -> Void
    // Action to perform when the user confirms deletion
    let onDelete: () -> Void

    // Defines the layout and style of the alert
    var body: some View {
        // Main stack to layer the dimmed background and the alert card
        ZStack {
            // Semi-transparent black background that dismisses the alert when tapped
            Color.black.opacity(0.45).ignoresSafeArea().onTapGesture { onCancel() }

            // Vertical stack that contains all the alert content
            VStack(spacing: 14) {
                // Title text (e.g., "Delete Journal?")
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Message text explaining the action
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.75))
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Horizontal stack for the Cancel and Delete buttons
                HStack(spacing: 12) {
                    // Cancel button — dismisses the alert without deleting
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.15), in: Capsule())
                    }

                    // Delete button — confirms and executes the delete action
                    Button(action: onDelete) {
                        Text("Delete")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.red, in: Capsule())
                    }
                }
                // Adds a bit of spacing above the buttons
                .padding(.top, 4)
            }
            // Adds padding around the alert content
            .padding(18)
            // Adds a rounded dark background behind the alert
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.black.opacity(0.55))
                    .shadow(color: .black.opacity(0.5), radius: 30, x: 0, y: 20)
            )
            // Adds a subtle white border outline around the alert
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            // Adds horizontal spacing from screen edges
            .padding(.horizontal, 32)
        }
    }
}
