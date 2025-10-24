import SwiftUI

struct SortMenuView: View {
    @Binding var sortOption: SortOption

    var body: some View {
        Menu {
            Button("Sort by Date") { sortOption = .dateDescending }
            Button("Sort by Bookmark") { sortOption = .bookmark }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white.opacity(0.9))
        }
    }
}
