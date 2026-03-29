//
//  AddPasswordView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 05/01/26.
//

import SwiftUI

struct AddPasswordView: View {
    
    @State private var websiteOrLabel: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    var isDisbaled: Bool {
        return websiteOrLabel.isEmpty || username.isEmpty || password.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                //Label View
                HStack {
                    IconImageView(height: 55, width: 55)
                    Spacer()
                    TextField("Website or Label", text: $websiteOrLabel)
                        .fontWeight(.semibold)
                        .padding()
                }
                
                //Username view
                Divider()
                HStack {
                    Text("Username")
                        .font(.headline)
                    
                    TextField("user", text: $username)
                        .multilineTextAlignment(.trailing)
                }
                
                //password view
                Divider()
                HStack {
                    Text("Password")
                        .font(.headline)
                    
                    TextField("password", text: $password)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Save tapped")
                        let passwordItem = PasswordItem(id: UUID().uuidString,
                                                        website: websiteOrLabel,
                                                        username: username,
                                                        password: password)
                        viewModel.savePasswordItem(passwordItem)
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    .disabled(isDisbaled)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
            )
            Spacer()
        }
    }
}

#Preview {
    AddPasswordView()
}
