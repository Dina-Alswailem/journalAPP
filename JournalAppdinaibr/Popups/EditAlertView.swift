import SwiftUI

struct EditAlertView: View {
    var onDiscard: () -> Void
    var onKeepEditing: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { onKeepEditing() }

            VStack(spacing: 12) {
                Text("Are you sure you want to discard changes on this journal?")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 6)

                Button(action: onDiscard) {
                    Text("Discard Changes")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.15), in: Capsule())
                }

                Button(action: onKeepEditing) {
                    Text("Keep Editing")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.12), in: Capsule())
                }
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.black.opacity(0.55))
                    .shadow(color: .black.opacity(0.5), radius: 30, x: 0, y: 20)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .padding(.horizontal, 36)
        }
    }
}
