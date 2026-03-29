//
//  ViewModel.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 06/01/26.
//

import Foundation

enum PasswordSortKey: String, CaseIterable, Identifiable {
    case title
    case website
    case dateEdited
    case dateCreated
    
    var id: String {
        rawValue
    }
    
    var label: String {
        switch self {
        case .title:
            return "Title"
        case .website:
           return "Website"
        case .dateEdited:
           return "Date Edited"
        case .dateCreated:
           return "Date Created"
        }
    }
    
    var iconName: String {
        switch self {
        case .title:
            return "textformat"
        case .website:
            return "globe"
        case .dateEdited:
            return "pencil"
        case .dateCreated:
            return "calendar.badge.plus"
            
        }
    }
}

enum PasswordSortDirection: String, CaseIterable, Identifiable {
    case ascending
    case descending
    
    var id: String {
        rawValue
    }
    
    var label: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
    
    var iconName: String {
        switch self {
        case .ascending:
            return "arrow.up"
        case .descending:
            return "arrow.down"
        }
    }
}

class ViewModel: ObservableObject {
    
    var manager: KeychainManager
    @Published var passwordItem = [PasswordItem]()
    @Published var searchtext: String = ""
    @Published var selectedSortKey: PasswordSortKey = .title
    @Published var selectedSortDirection: PasswordSortDirection = .ascending
    
    init(manager: KeychainManager) {
        self.manager = manager
        self.passwordItem = manager.fetchAll()
    }
    
    var filteredAndSortedPasswordItems: [PasswordItem] {
        let filteredItems = passwordItem.filter { item in
            searchtext.isEmpty ||
            item.website.localizedCaseInsensitiveContains(searchtext) ||
            item.username.localizedCaseInsensitiveContains(searchtext)
        }
        
        let ascending = filteredItems.sorted { lhs, rhs in
            switch selectedSortKey {
            case .title:
                return lhs.username.localizedCaseInsensitiveCompare(rhs.username) == .orderedAscending
            case .website:
                return lhs.website.localizedCaseInsensitiveCompare(rhs.website) == .orderedAscending
            default:
                return lhs.date < rhs.date
            }
        }
        return selectedSortDirection == .ascending ? ascending : ascending.reversed()
    }
    
    func fetchAllPasswordItems() {
        self.passwordItem = manager.fetchAll()
    }
    
    func savePasswordItem(_ item: PasswordItem) {
        do {
            try manager.save(website: item.website,
                             username: item.username,
                             password: item.password.data(using: .utf8) ?? Data())
            fetchAllPasswordItems()
        } catch {
            print("Error While Saving Password\(error.localizedDescription)")
        }
    }
    
    func deletePassword(item: PasswordItem) {
        do {
            try manager.delete(website: item.website, username: item.username)
            fetchAllPasswordItems()
        } catch {
            print("Error While Deleting Password\(error.localizedDescription)")
        }
    }
    
    func updatePassword(item: PasswordItem) {
        do {
            try manager.update(website: item.website,
                               username: item.username,
                               newPassword: item.password.data(using: .utf8) ?? Data())
            fetchAllPasswordItems()
        } catch {
            print("Error while updating Password\(error.localizedDescription)")
        }
    }
}
