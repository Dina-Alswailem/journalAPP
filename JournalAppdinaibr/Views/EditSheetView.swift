import SwiftUI

// A view for editing an existing journal entry inside a modal sheet
struct EditSheetView: View {
    // Holds the journal entry currently being edited
    @State var journal: Journal
    // Accent color used for highlights and buttons
    var accent: Color
    // Closure executed when the user saves the edited journal
    var onSave: (Journal) -> Void
    // Closure executed when the user cancels editing
    var onCancel: () -> Void

    // Environment variable used to dismiss the sheet
    @Environment(\.dismiss) private var dismiss
    // State variable controlling the visibility of the discard confirmation modal
    @State private var showDiscardModal = false

    // Describes the layout and behavior of the edit sheet
    var body: some View {
        // ZStack to layer the main editor and the discard alert
        ZStack {
            // Custom panel background (defined in Panel.swift)
            Panel {
                // Top bar with Cancel (X) and Save (Checkmark) buttons
                HStack {
                    // Cancel button — shows discard confirmation modal
                    CircleButton(symbol: "xmark", fg: .white, bg: .black.opacity(0.35)) {
                        withAnimation(.spring()) { showDiscardModal = true }
                    }

                    Spacer()

                    // Save button — saves journal and closes the sheet
                    CircleButton(symbol: "checkmark", fg: .white, bg: accent) {
                        onSave(journal)
                        dismiss()
                    }
                }
                // Adds padding around the top bar
                .padding(.horizontal, 8)
                .padding(.top, 6)

                // Vertical stack for the title, date, and content fields
                VStack(alignment: .leading, spacing: 14) {
                    // Editable title field with accent color
                    TextField("Title", text: $journal.title)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(accent)
                        .tint(accent)

                    // Displays formatted journal date
                    Text(journal.date.pretty)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))

                    // Editable text area for the journal content
                    TextEditor(text: $journal.content)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 220)
                }
                // Adds horizontal padding for text fields
                .padding(.horizontal, 8)

                // Keeps some space at the bottom to avoid layout compression
                Spacer(minLength: 0)
            }

            // Overlay confirmation modal when user tries to discard edits
            if showDiscardModal {
                EditAlertView(
                    onDiscard: { onCancel(); dismiss() },
                    onKeepEditing: { withAnimation(.spring()) { showDiscardModal = false } }
                )
                // Adds a smooth fade + scale transition for showing/hiding the alert
                .transition(.opacity.combined(with: .scale))
            }
        }
    }
}
