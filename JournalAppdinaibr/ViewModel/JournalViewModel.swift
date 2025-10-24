import SwiftUI
import Combine




final class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    @Published var searchText: String = ""
    @Published var activeSheet: ActiveSheet? = nil
    @Published var showDeleteConfirm: Bool = false
    @Published var pendingDeleteIndex: Int? = nil
    @Published var sortOption: SortOption = .dateDescending
}

// MARK: - Shared enums
enum SortOption { case dateDescending, bookmark }

enum ActiveSheet: Identifiable, Equatable {
    case create
    case edit(Journal)
    var id: String {
        switch self {
        case .create: return "create"
        case .edit(let j): return "edit-\(j.id)"
        }
    }
}

// MARK: - CRUD
extension JournalViewModel {
    func addJournal(title: String, content: String) {
        journals.append(Journal(title: title.isEmpty ? "Untitled" : title, content: content, date: .now))
    }
    func updateJournal(_ updated: Journal) {
        if let i = journals.firstIndex(where: { $0.id == updated.id }) { journals[i] = updated }
    }
    func deleteJournal(at index: Int) { journals.remove(at: index) }
}
