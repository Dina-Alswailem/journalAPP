import SwiftUI

// A simple splash screen that shows the app logo and title before transitioning to the main view
struct SplashScreen: View {
    // Tracks whether to show the splash or move to the main screen
    @State private var isActive = false

    // MARK: - Body
    var body: some View {
        // When the splash timer ends, show the main app view
        if isActive {
            EmptyStateView()
        } else {
            // Splash screen background and content
            ZStack {
                // Gradient background from dark to slightly lighter tone
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black,
                        Color(red: 0.07, green: 0.07, blue: 0.14)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Centered logo and text
                VStack(spacing: 16) {
                    // App logo image
                    Image("journalLogo")
                        .resizable()
                        .frame(width: 120, height: 120)

                    // App name text
                    Text("Journali")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)

                    // App slogan text
                    Text("Your thoughts, your story")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            // Trigger after the splash appears
            .onAppear {
                // Wait 5 seconds before transitioning to the main screen
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation { isActive = true }
                }
            }
        }
    }
}

// Preview for Xcode Canvas
#Preview { SplashScreen() }
