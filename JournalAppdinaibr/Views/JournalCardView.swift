import SwiftUI

// A single card view displaying a journal entry with swipe-to-delete and edit functionality
struct JournalCardView: View {
    // Binding to the journal data (allows two-way updates)
    @Binding var journal: Journal
    // Accent color used for highlights and icons
    let accent: Color
    // Action executed when the user chooses to delete the journal
    let onDelete: () -> Void
    // Action executed when the user chooses to edit the journal
    let onEdit: () -> Void

    // Tracks horizontal drag offset for swipe gestures
    @State private var offsetX: CGFloat = 0
    // Determines if the delete button should be visible
    @State private var showDeleteButton = false

    // MARK: - Body
    var body: some View {
        // ZStack allows layering the delete button behind the journal card
        ZStack(alignment: .trailing) {
            // Background layer: shows delete button when swiped left
            if showDeleteButton {
                HStack {
                    Spacer()
                    // Delete button (appears when swiped)
                    Button(action: {
                        withAnimation(.spring()) { onDelete(); resetCard() }
                    }) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 24)
                }
            }

            // Main journal card content
            VStack(alignment: .leading, spacing: 10) {
                // Title and bookmark icon
                HStack {
                    // Journal title
                    Text(journal.title)
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundColor(accent)
                    Spacer()
                    // Bookmark toggle button
                    Button { journal.isBookmarked.toggle() } label: {
                        Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(accent)
                    }
                }

                // Journal date
                Text(journal.date.pretty)
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.6))

                // Journal content preview (limited to 3 lines)
                Text(journal.content)
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.92))
                    .lineLimit(3)
            }
            // Card styling: padding, background, border, shadow
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 22).fill(Color.white.opacity(0.06)))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.white.opacity(0.08), lineWidth: 1))
            .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 8)
            // Offset card horizontally during swipe
            .offset(x: offsetX)
            // Swipe gesture handling
            .gesture(
                DragGesture()
                    // While dragging horizontally
                    .onChanged { g in
                        withAnimation(.easeInOut(duration: 0.15)) {
                            if g.translation.width < 0 {
                                offsetX = g.translation.width
                                showDeleteButton = abs(g.translation.width) > 30
                            }
                        }
                    }
                    // When drag ends, decide whether to reveal delete button or reset
                    .onEnded { g in
                        withAnimation(.spring()) {
                            if abs(g.translation.width) > 100 {
                                offsetX = -90
                                showDeleteButton = true
                            } else {
                                resetCard()
                            }
                        }
                    }
            )
            // Tap on card triggers edit action
            .onTapGesture { onEdit() }
        }
        // Makes the card take full available width
        .frame(maxWidth: .infinity)
    }

    // MARK: - Helper Function
    // Resets card position and hides delete button
    private func resetCard() {
        withAnimation(.spring()) {
            offsetX = 0
            showDeleteButton = false
        }
    }
}
