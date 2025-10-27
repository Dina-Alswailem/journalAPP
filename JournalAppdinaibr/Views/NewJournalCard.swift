import SwiftUI

// A view that allows the user to create a new journal entry
struct NewJournalCard: View {
    // Accent color for buttons and highlights
    var accent: Color
    // Closure called when a new journal is created
    var onCreate: (Journal) -> Void
    // Closure called when the user cancels journal creation
    var onCancel: () -> Void

    // Environment variable to dismiss the current sheet
    @Environment(\.dismiss) private var dismiss
    // State variables to store user input for title and content
    @State private var title: String = ""
    @State private var content: String = ""

    // MARK: - Body
    var body: some View {
        // Panel is a custom container with rounded background and padding
        Panel {
            // Top bar with Cancel (X) and Save (✓) buttons
            HStack {
                // Cancel button: closes the sheet and triggers onCancel
                CircleButton(symbol: "xmark", fg: .white, bg: .black.opacity(0.35)) {
                    onCancel()
                    dismiss()
                }
                Spacer()
                // Save button: creates a new journal and closes the sheet
                CircleButton(symbol: "checkmark", fg: .white, bg: accent) {
                    onCreate(Journal(title: title.isEmpty ? "Untitled" : title, content: content, date: .now))
                    dismiss()
                }
            }
            // Padding for the top bar layout
            .padding(.horizontal, 8)
            .padding(.top, 6)

            // Input fields for the journal title and content
            VStack(alignment: .leading, spacing: 14) {
                // Title text field
                TextField("Title", text: $title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(accent)
                    .tint(accent)

                // Current date display
                Text(Date.now.pretty)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))

                // Text editor for journal content with placeholder
                ZStack(alignment: .topLeading) {
                    // Placeholder text shown only when content is empty
                    if content.isEmpty {
                        Text("Type your Journal...")
                            .foregroundColor(.white.opacity(0.3))
                            .padding(.top, 8)
                    }

                    // Text editor where user writes journal content
                    TextEditor(text: $content)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 220)
                }
            }
            // Adds side padding for text fields
            .padding(.horizontal, 8)

            // Spacer pushes content up (keeps bottom space flexible)
            Spacer(minLength: 0)
        }
        // Transparent background for the sheet
        .background(Color.clear)
    }
}
