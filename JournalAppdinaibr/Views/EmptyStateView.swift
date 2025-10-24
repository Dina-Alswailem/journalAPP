import SwiftUI
import UIKit

struct EmptyStateView: View {
    @StateObject private var vm = JournalViewModel()

    private let bg     = Color(red: 15/255,  green: 15/255,  blue: 15/255)
    private let accent = Color(red: 187/255, green: 168/255, blue: 255/255)

    var body: some View {
        ZStack {
            bg.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                Group { vm.journals.isEmpty ? AnyView(emptyState) : AnyView(listView) }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .safeAreaInset(edge: .bottom) {
                SearchBarView(text: $vm.searchText, accent: accent).background(.clear)
            }

            if vm.showDeleteConfirm {
                DeleteAlertView(
                    title: "Delete Journal?",
                    message: "Are you sure you want to delete this journal?",
                    onCancel: {
                        withAnimation(.spring()) {
                            vm.showDeleteConfirm = false
                            vm.pendingDeleteIndex = nil
                        }
                    },
                    onDelete: {
                        if let idx = vm.pendingDeleteIndex { vm.deleteJournal(at: idx) }
                        withAnimation(.spring()) {
                            vm.showDeleteConfirm = false
                            vm.pendingDeleteIndex = nil
                        }
                    }
                )
                .transition(.opacity.combined(with: .scale))
            }
        }
        .sheet(item: $vm.activeSheet) { sheet in
            ZStack {
                ClearSheetBackground()
                switch sheet {
                case .create:
                    NewJournalCard(
                        accent: accent,
                        onCreate: { new in vm.addJournal(title: new.title, content: new.content); vm.activeSheet = nil },
                        onCancel: { vm.activeSheet = nil }
                    )
                case .edit(let original):
                    EditSheetView(
                        journal: original,
                        accent: accent,
                        onSave: { updated in vm.updateJournal(updated); vm.activeSheet = nil },
                        onCancel: { vm.activeSheet = nil }
                    )
                }
            }
            .preferredColorScheme(.dark)
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }

    // Top Bar
    private var topBar: some View {
        ZStack {
            HStack {
                Text("Journal")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                Spacer()
            }
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

    // Empty
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image("emptyJournal").resizable().scaledToFit().frame(width: 200, height: 200)
            Text("Begin Your Journal")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(accent)
            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // List
    // MARK: - List
    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(mappedItems, id: \.item.id) { pair in
                    JournalCardView(
                        journal: Binding(
                            get: { vm.journals[pair.index] },
                            set: { vm.journals[pair.index] = $0 }
                        ),
                        accent: accent,
                        onDelete: {
                            vm.pendingDeleteIndex = pair.index
                            withAnimation { vm.showDeleteConfirm = true }
                        },
                        onEdit: {
                            vm.activeSheet = .edit(vm.journals[pair.index])
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.visible)
        .scrollDismissesKeyboard(.interactively)
    }


    // Mapping indices (لأننا نفرز/نفلتر)
    private var mappedItems: [(index: Int, item: Journal)] {
        var filtered = vm.journals
        if !vm.searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(vm.searchText) ||
                $0.content.localizedCaseInsensitiveContains(vm.searchText)
            }
        }
        switch vm.sortOption {
        case .dateDescending:
            filtered = filtered.sorted { $0.date > $1.date }
        case .bookmark:
            filtered = filtered.sorted {
                ($0.isBookmarked ? 1 : 0, $0.date) >
                ($1.isBookmarked ? 1 : 0, $1.date)
            }
        }
        return filtered.compactMap { item in
            if let idx = vm.journals.firstIndex(where: { $0.id == item.id }) { return (idx, item) }
            return nil
        }
    }
}

// خلفية الشيت الشفافة (نفس كودك)
private struct ClearSheetBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.findSuper(ofType: UIView.self)?.backgroundColor = .clear
            view.superview?.superview?.backgroundColor = .clear
            view.window?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}
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

