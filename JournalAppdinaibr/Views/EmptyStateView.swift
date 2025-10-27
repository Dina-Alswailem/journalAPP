import SwiftUI
import UIKit

// The main view that represents the home screen of the Journal app.
// Displays either an empty state or a list of existing journals.
struct EmptyStateView: View {
    // ViewModel object that manages journal data and app state
    @StateObject private var vm = JournalViewModel()

    // Background and accent color constants
    private let bg     = Color(red: 15/255,  green: 15/255,  blue: 15/255)
    private let accent = Color(red: 187/255, green: 168/255, blue: 255/255)

    // MARK: - Body
    var body: some View {
        // ZStack layers background, content, and modals
        ZStack {
            // App background color fills entire screen
            bg.ignoresSafeArea()

            // Main content vertical stack (Top bar + main view)
            VStack(spacing: 0) {
                topBar
                // Conditionally show empty state or journal list
                Group { vm.journals.isEmpty ? AnyView(emptyState) : AnyView(listView) }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            // Search bar placed at the bottom, floating style
            .safeAreaInset(edge: .bottom) {
                SearchBarView(text: $vm.searchText, accent: accent).background(.clear)
            }

            // Delete confirmation alert overlay
            if vm.showDeleteConfirm {
                DeleteAlertView(
                    title: "Delete Journal?",
                    message: "Are you sure you want to delete this journal?",
                    onCancel: {
                        // Close alert and reset pending index
                        withAnimation(.spring()) {
                            vm.showDeleteConfirm = false
                            vm.pendingDeleteIndex = nil
                        }
                    },
                    onDelete: {
                        // Delete the journal and close alert
                        if let idx = vm.pendingDeleteIndex { vm.deleteJournal(at: idx) }
                        withAnimation(.spring()) {
                            vm.showDeleteConfirm = false
                            vm.pendingDeleteIndex = nil
                        }
                    }
                )
                // Smooth transition for alert appearance/disappearance
                .transition(.opacity.combined(with: .scale))
            }
        }
        // Presents sheet for creating or editing journals
        .sheet(item: $vm.activeSheet) { sheet in
            ZStack {
                // Transparent background under the sheet
                ClearSheetBackground()
                switch sheet {
                case .create:
                    // New journal creation card
                    NewJournalCard(
                        accent: accent,
                        onCreate: { new in vm.addJournal(title: new.title, content: new.content); vm.activeSheet = nil },
                        onCancel: { vm.activeSheet = nil }
                    )
                case .edit(let original):
                    // Editing existing journal card
                    EditSheetView(
                        journal: original,
                        accent: accent,
                        onSave: { updated in vm.updateJournal(updated); vm.activeSheet = nil },
                        onCancel: { vm.activeSheet = nil }
                    )
                }
            }
            // Sheet configuration (dark mode, large size, no drag indicator)
            .preferredColorScheme(.dark)
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }

    // MARK: - Top Bar
    // Displays app title and action buttons (sort + add)
    private var topBar: some View {
        ZStack {
            // Left: App title
            HStack {
                Text("Journal")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                Spacer()
            }
            // Right: Sort and Add buttons inside a capsule
            HStack {
                Spacer()
                HStack(spacing: 10) {
                    SortMenuView(sortOption: $vm.sortOption)
                    CircleButton(symbol: "plus", fg: .white, bg: .clear) { vm.activeSheet = .create }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(Capsule().stroke(Color.white.opacity(0.08), lineWidth: 1))
                .padding(.trailing, 20)
            }
        }
        .padding(.top, 44)
        .padding(.bottom, 10)
    }

    // MARK: - Empty State
    // Shown when there are no journals yet
    private var emptyState: some View {
        VStack(spacing: 16) {
            // Empty state illustration image
            Image("emptyJournal").resizable().scaledToFit().frame(width: 200, height: 200)
            // Title encouraging the user to start journaling
            Text("Begin Your Journal")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(accent)
            // Subtitle description
            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - List View
    // Displays list of journals if not empty
    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                // Iterates over journals with their indices
                ForEach(mappedItems, id: \.item.id) { pair in
                    JournalCardView(
                        // Two-way binding for each journal entry
                        journal: Binding(
                            get: { vm.journals[pair.index] },
                            set: { vm.journals[pair.index] = $0 }
                        ),
                        accent: accent,
                        // Delete action with confirmation alert
                        onDelete: {
                            vm.pendingDeleteIndex = pair.index
                            withAnimation { vm.showDeleteConfirm = true }
                        },
                        // Opens edit sheet for selected journal
                        onEdit: {
                            vm.activeSheet = .edit(vm.journals[pair.index])
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        // Enables scroll indicators and dismissing keyboard by dragging
        .scrollIndicators(.visible)
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Filter + Sort Mapping
    // Filters and sorts journals based on search and sort options
    private var mappedItems: [(index: Int, item: Journal)] {
        var filtered = vm.journals
        // Filters journals by search text (case-insensitive)
        if !vm.searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(vm.searchText) ||
                $0.content.localizedCaseInsensitiveContains(vm.searchText)
            }
        }
        // Sorting logic: by date or by bookmark
        switch vm.sortOption {
        case .dateDescending:
            filtered = filtered.sorted { $0.date > $1.date }
        case .bookmark:
            filtered = filtered.sorted {
                ($0.isBookmarked ? 1 : 0, $0.date) >
                ($1.isBookmarked ? 1 : 0, $1.date)
            }
        }
        // Maps back filtered items to their original indices
        return filtered.compactMap { item in
            if let idx = vm.journals.firstIndex(where: { $0.id == item.id }) { return (idx, item) }
            return nil
        }
    }
}

// MARK: - Transparent Sheet Background
// Makes the sheet background transparent for custom overlay effects
private struct ClearSheetBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        // Asynchronously clears background colors of parent views
        DispatchQueue.main.async {
            view.findSuper(ofType: UIView.self)?.backgroundColor = .clear
            view.superview?.superview?.backgroundColor = .clear
            view.window?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - UIView Extension
// Helper to find a superview of a specific type
private extension UIView {
    func findSuper<T: UIView>(ofType: T.Type) -> T? {
        var v: UIView? = self
        while let s = v?.superview {
            if let match = s as? T { return match }
            v = s
        }
        return nil
    }
}
