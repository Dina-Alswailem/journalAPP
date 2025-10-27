import SwiftUI
import Combine

// The main ViewModel responsible for managing all journal-related data and state
final class JournalViewModel: ObservableObject {
    // Stores all journal entries
    @Published var journals: [Journal] = []
    // Holds the current text entered in the search bar
    @Published var searchText: String = ""
    // Tracks which sheet (create/edit) is currently active
    @Published var activeSheet: ActiveSheet? = nil
    // Controls the visibility of the delete confirmation alert
    @Published var showDeleteConfirm: Bool = false
    // Stores the index of the journal that is pending deletion
    @Published var pendingDeleteIndex: Int? = nil
    // Determines how the list of journals is sorted (by date or bookmark)
    @Published var sortOption: SortOption = .dateDescending
}

// MARK: - Shared enums

// Defines sorting options for displaying journals
enum SortOption {
    case dateDescending   // Sorts journals by most recent date first
    case bookmark         // Shows bookmarked journals first
}

// Represents the active sheet being shown (Create or Edit)
enum ActiveSheet: Identifiable, Equatable {
    // Option for creating a new journal
    case create
    // Option for editing an existing journal
    case edit(Journal)
    
    // Unique ID for each case (used by SwiftUI)
    var id: String {
        switch self {
        case .create: return "create"
        case .edit(let j): return "edit-\(j.id)"
        }
    }
}

// MARK: - CRUD (Create, Read, Update, Delete)
extension JournalViewModel {
    // Adds a new journal entry with the given title and content
    func addJournal(title: String, content: String) {
        journals.append(Journal(title: title.isEmpty ? "Untitled" : title, content: content, date: .now))
    }

    // Updates an existing journal entry by matching its ID
    func updateJournal(_ updated: Journal) {
        if let i = journals.firstIndex(where: { $0.id == updated.id }) {
            journals[i] = updated
        }
    }

    // Deletes a journal entry at the given index
    func deleteJournal(at index: Int) {
        journals.remove(at: index)
    }
}
