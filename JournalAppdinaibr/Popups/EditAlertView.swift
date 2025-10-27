import SwiftUI

// A custom alert view shown when the user tries to leave edit mode without saving
struct EditAlertView: View {
    // Action executed when the user chooses to discard changes
    var onDiscard: () -> Void
    // Action executed when the user decides to continue editing
    var onKeepEditing: () -> Void

    // Defines the view’s structure and appearance
    var body: some View {
        // ZStack layers the background and alert content
        ZStack {
            // Dimmed black background that dismisses the alert when tapped
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { onKeepEditing() }

            // Vertical stack for the message and two action buttons
            VStack(spacing: 12) {
                // Message asking for confirmation before discarding edits
                Text("Are you sure you want to discard changes on this journal?")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 6)

                // Button to discard unsaved changes
                Button(action: onDiscard) {
                    Text("Discard Changes")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.15), in: Capsule())
                }

                // Button to cancel and continue editing
                Button(action: onKeepEditing) {
                    Text("Keep Editing")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.12), in: Capsule())
                }
            }
            // Adds internal padding inside the alert box
            .padding(18)
            // Adds rounded dark background with subtle shadow
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.black.opacity(0.55))
                    .shadow(color: .black.opacity(0.5), radius: 30, x: 0, y: 20)
            )
            // Adds a light white border overlay for depth
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            // Adds horizontal padding to center the alert
            .padding(.horizontal, 36)
        }
    }
}
