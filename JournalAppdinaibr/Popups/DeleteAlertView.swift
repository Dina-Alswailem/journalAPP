import SwiftUI

struct DeleteAlertView: View {
    let title: String
    let message: String
    let onCancel: () -> Void
    let onDelete: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.45).ignoresSafeArea().onTapGesture { onCancel() }
            VStack(spacing: 14) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.75))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 12) {
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.15), in: Capsule())
                    }
                    Button(action: onDelete) {
                        Text("Delete")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.red, in: Capsule())
                    }
                }.padding(.top, 4)
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
            .padding(.horizontal, 32)
        }
    }
}
