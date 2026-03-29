//
//  PasswordManagerApp.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 02/01/26.
//

import SwiftUI

@main
struct PasswordManagerApp: App {
    @StateObject private var viewModel: ViewModel = ViewModel(manager: KeychainManager())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
