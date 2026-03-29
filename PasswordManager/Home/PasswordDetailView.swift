//
//  PasswordDetailView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 04/01/26.
//

import SwiftUI

struct PasswordDetailView: View {
    @Binding var passwordItem: PasswordItem
    @Binding var show: Bool
    @State var didHidePassword: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            //upper view
            HStack {
                IconImageView(height: 65,
                              width: 65,
                              icon: passwordItem.website.first?.uppercased() ?? "")
                    
                VStack(alignment: .leading) {
                    Text(passwordItem.website)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Last modfified \(passwordItem.formattedDate)")
                        .font(.system(size: 13))
                }
                .padding()
            }
            
            Divider()
            //username View
            HStack {
                Text("Username")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                Text(passwordItem.username)
                    .foregroundStyle(.gray)
            }
            
            Divider()
            //Passkey View
            HStack {
                Text("Passkey")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                Text(didHidePassword ? String(repeating: "●", count: passwordItem.password.count) : passwordItem.password)
                    .foregroundStyle(.gray)
                
                Button {
                    didHidePassword.toggle()
                } label: {
                    Image(systemName: didHidePassword ? "eye" : "eye.slash")
                        .foregroundStyle(.black)
                }
                .padding(.leading)

            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("edit tapped")
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Text("Edit")
                        .font(.system(size: 18))
                }

            }
        }
        Spacer()
    }
}

#Preview {
    PasswordDetailView(passwordItem: .constant(PasswordItem(id: "",
                                                            website: "",
                                                            username: "",
                                                            password: "")),
                       show: .constant(false))
}
