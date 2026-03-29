//
//  KeychainManager.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 05/01/26.
//

import Foundation

enum KeychainError: Error {
    case duplicateEntry
    case itemNotFound
    case deleteFailed
    case otherError(OSStatus)
}

class KeychainManager {
    
    func save(website: String,
              username: String,
              password: Data) throws {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: website,
            kSecAttrAccount as String: username,
            kSecValueData as String: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.otherError(status)
        }
        print("Saved Successfully")
    }
    
    func delete(website: String, username: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: website,
            kSecAttrAccount as String: username
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.deleteFailed
        }
        print("deleted successfully")
    }
    
    func update(website: String, username: String, newPassword: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: website,
            kSecAttrAccount as String: username
        ]
        
        let queryToUpdate: [String: Any] = [
            kSecValueData as String: newPassword
        ]
        
        let status = SecItemUpdate(query as CFDictionary, queryToUpdate as CFDictionary)
        
        if status == errSecItemNotFound {
            do {
                try self.save(website: website, username: username, password: newPassword)
            } catch {
                print("Failed to save Password\(error.localizedDescription)")
            }
        } else if status != errSecSuccess {
            throw KeychainError.otherError(status)
        }
        
        print("updated successfully")
    }
    
     func fetchAll() ->  [PasswordItem] {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
    
        guard status == errSecSuccess,
              let item = result as? [[String: Any]] else {
            return []
        }
        
         return item.compactMap{
             guard let website = $0[kSecAttrService as String] as? String,
                   let username = $0[kSecAttrAccount as String] as? String,
                   let data = $0[kSecValueData as String] as? Data,
                   let dateCreated = $0[kSecAttrCreationDate as String] as? Date else {
                 return nil
             }
             
             var date: Date = dateCreated
             if let dateEdited = $0[kSecAttrModificationDate as String] as? Date {
                 date = dateEdited
             }
             
             return PasswordItem(id: "\(website) | \(username)",
                                 website: website,
                                 username: username,
                                 password: String(data: data, encoding: .utf8) ?? "",
                                 date: date)
        }
    }
    
}
