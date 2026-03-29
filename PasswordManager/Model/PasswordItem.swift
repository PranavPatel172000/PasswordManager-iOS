//
//  PasswordItem.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 06/01/26.
//

import Foundation

struct PasswordItem: Identifiable, Hashable {
    let id: String
    var website: String
    var username: String
    var password: String
    var date: Date
    
    init(id: String, website: String, username: String, password: String, date: Date = Date()) {
        self.id = id
        self.website = website
        self.username = username
        self.password = password
        self.date = date
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH.mm.ss"
        return dateFormatter.string(from: date)
    }
    
    
}
