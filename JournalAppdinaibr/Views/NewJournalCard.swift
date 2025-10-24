import SwiftUI

struct NewJournalCard: View {
    var accent: Color
    var onCreate: (Journal) -> Void
    var onCancel: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        Panel {
            HStack {
                CircleButton(symbol: "xmark", fg: .white, bg: .black.opacity(0.35)) {
                    onCancel(); dismiss()
                }
                Spacer()
                CircleButton(symbol: "checkmark", fg: .white, bg: accent) {
                    onCreate(Journal(title: title.isEmpty ? "Untitled" : title, content: content, date: .now))
                    dismiss()
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 6)

            VStack(alignment: .leading, spacing: 14) {
                TextField("Title", text: $title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(accent)
                    .tint(accent)
                Text(Date.now.pretty)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
                ZStack(alignment: .topLeading) {
                    if content.isEmpty {
                        Text("Type your Journal...")
                            .foregroundColor(.white.opacity(0.3))
                            .padding(.top, 8)
                    }
                    TextEditor(text: $content)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 220)
                }
            }
            .padding(.horizontal, 8)
            Spacer(minLength: 0)
        }
        .background(Color.clear)
    }
}

