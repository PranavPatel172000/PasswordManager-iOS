//
//  EditPasswordView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 07/01/26.
//

import SwiftUI

struct EditPasswordView: View {
    @State var newPassword: String = ""
    @Binding var show: Bool
    @Binding var passwordItem: PasswordItem
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("cancel tapped on edit view")
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
            }
            .padding(.bottom)
            
            // Top View
                VStack(alignment: .leading) {
                    HStack {
                        IconImageView(height: 55, width: 55, icon: passwordItem.website.first?.uppercased() ?? "")
                        
                        VStack(alignment: .leading) {
                            Text(passwordItem.website)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                            
                            Text("Last modified \(passwordItem.formattedDate)")
                                .font(.system(size: 13))
                        }
                        .padding()
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Username")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text(passwordItem.username)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
                
                VStack(alignment: .leading) {
                    TextField("Password", text: $newPassword)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Divider()
                    
                    Button {
                        guard !newPassword.isEmpty else {
                            return
                        }
                        passwordItem.password = newPassword
                        viewModel.updatePassword(item: passwordItem)
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        Text("Change Password....")
                            .padding(.top, 3)
                            .font(.title3)
                    }
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
                
                Button {
                    print("Delete tapped")
                    showAlert.toggle()
                } label: {
                    Text("Delete")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
                .foregroundStyle(.red)
            
            Spacer()
        }
        .confirmationDialog("Delete Password",
                            isPresented: $showAlert) {
            
            Button(role: .destructive) {
                let passwordItem = PasswordItem(id: UUID().uuidString,
                                                website: passwordItem.website,
                                                username: passwordItem.username,
                                                password: passwordItem.password)
                viewModel.deletePassword(item: passwordItem)
                dismiss()
            } label: {
                Text("Delete Password")
            }

            Button(role: .cancel) {
                showAlert.toggle()
            } label: {
                Text("Cancel")
            }

        } message: {
            Text("""
This password will be moved to Recently Deleted.After 30 days, it will be permanently deleted.
""")
        }
    }
}



#Preview {
    EditPasswordView(show: .constant(false), passwordItem: .constant(PasswordItem(id: "",
                                                                                  website: "",
                                                                                  username: "",
                                                                                  password: "")))
}
