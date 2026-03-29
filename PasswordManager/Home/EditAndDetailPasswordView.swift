//
//  EditAndDetailPasswordView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 08/01/26.
//

import SwiftUI

struct EditAndDetailPasswordView: View {
    @Binding var passwordItem: PasswordItem
    @State var showEditPasswordView: Bool = false
    
    var body: some View {
        if showEditPasswordView {
            EditPasswordView(show: $showEditPasswordView,
                             passwordItem: $passwordItem)
                .toolbar(.hidden, for: .navigationBar)
        } else {
            PasswordDetailView(passwordItem: $passwordItem,
                               show: $showEditPasswordView)
        }
        
    }
}

#Preview {
    EditAndDetailPasswordView(passwordItem: .constant(PasswordItem(id: "",
                                                                   website: "",
                                                                   username: "",
                                                                   password: "")))
}
