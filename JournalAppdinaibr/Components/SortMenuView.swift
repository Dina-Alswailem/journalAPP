import SwiftUI

// A view that provides a menu for sorting journal entries
struct SortMenuView: View {
    // A binding to the current sorting option (shared state with parent view)
    @Binding var sortOption: SortOption

    // Defines how the view looks and behaves
    var body: some View {
        // A menu that opens when the label (icon) is tapped
        Menu {
            // Option 1: Sort journals by date (newest first)
            Button("Sort by Date") { sortOption = .dateDescending }
            // Option 2: Sort journals by bookmark status
            Button("Sort by Bookmark") { sortOption = .bookmark }
        } label: {
            // The icon shown for the menu (three horizontal lines with a circle)
            Image(systemName: "line.3.horizontal.decrease.circle")
                // Sets the icon font size and weight
                .font(.system(size: 18, weight: .semibold))
                // Slightly transparent white color for the icon
                .foregroundColor(.white.opacity(0.9))
        }
    }
}
