import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            EmptyStateView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [ Color.black, Color(red: 0.07, green: 0.07, blue: 0.14) ]),
                    startPoint: .top, endPoint: .bottom
                ).ignoresSafeArea()

                VStack(spacing: 16) {
                    Image("journalLogo").resizable().frame(width: 120, height: 120)
                    Text("Journali").font(.system(size: 32, weight: .bold)).foregroundColor(.white)
                    Text("Your thoughts, your story").font(.system(size: 16)).foregroundColor(.white.opacity(0.7))
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation { isActive = true }
                }
            }
        }
    }
}

#Preview { SplashScreen() }
