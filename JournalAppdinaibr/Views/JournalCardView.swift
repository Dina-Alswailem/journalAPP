import SwiftUI

struct JournalCardView: View {
    @Binding var journal: Journal
    let accent: Color
    let onDelete: () -> Void
    let onEdit: () -> Void

    @State private var offsetX: CGFloat = 0
    @State private var showDeleteButton = false

    var body: some View {
        ZStack(alignment: .trailing) {
            if showDeleteButton {
                HStack {
                    Spacer()
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

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(journal.title)
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundColor(accent)
                    Spacer()
                    Button { journal.isBookmarked.toggle() } label: {
                        Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(accent)
                    }
                }
                Text(journal.date.pretty)
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.6))
                Text(journal.content)
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.92))
                    .lineLimit(3)
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 22).fill(Color.white.opacity(0.06)))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.white.opacity(0.08), lineWidth: 1))
            .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 8)
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { g in
                        withAnimation(.easeInOut(duration: 0.15)) {
                            if g.translation.width < 0 {
                                offsetX = g.translation.width
                                showDeleteButton = abs(g.translation.width) > 30
                            }
                        }
                    }
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
            .onTapGesture { onEdit() }
        }
        .frame(maxWidth: .infinity)
    }

    private func resetCard() {
        withAnimation(.spring()) { offsetX = 0; showDeleteButton = false }
    }
}

