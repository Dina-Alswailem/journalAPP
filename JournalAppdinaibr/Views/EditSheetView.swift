import SwiftUI

struct EditSheetView: View {
    @State var journal: Journal
    var accent: Color
    var onSave: (Journal) -> Void
    var onCancel: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var showDiscardModal = false

    var body: some View {
        ZStack {
            Panel {
                HStack {
                    CircleButton(symbol: "xmark", fg: .white, bg: .black.opacity(0.35)) {
                        withAnimation(.spring()) { showDiscardModal = true }
                    }
                    Spacer()
                    CircleButton(symbol: "checkmark", fg: .white, bg: accent) {
                        onSave(journal); dismiss()
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 6)

                VStack(alignment: .leading, spacing: 14) {
                    TextField("Title", text: $journal.title)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(accent)
                        .tint(accent)
                    Text(journal.date.pretty)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                    TextEditor(text: $journal.content)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 220)
                }
                .padding(.horizontal, 8)
                Spacer(minLength: 0)
            }
            if showDiscardModal {
                EditAlertView(
                    onDiscard: { onCancel(); dismiss() },
                    onKeepEditing: { withAnimation(.spring()) { showDiscardModal = false } }
                )
                .transition(.opacity.combined(with: .scale))
            }
        }
    }
}

