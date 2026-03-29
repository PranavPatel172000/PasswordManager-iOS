//
//  PasswordRowView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 02/01/26.
//

import SwiftUI

struct PasswordRowView: View {
    var passwordItem: PasswordItem
    var shouldShowBottomSeparator: Bool = false
    
    var body: some View {
            HStack {
                IconImageView(icon: passwordItem.website.first?.uppercased() ?? "")

                VStack(alignment: .leading) {
                    
                        Divider()
                            .padding(.bottom, 4)
                    
                    Text(passwordItem.website)
                        .fontWeight(.semibold)
                    
                    Text(passwordItem.username)
                    
                    if shouldShowBottomSeparator {
                        Divider()
                    }
                }
                .padding(.leading, 8)
                
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal)
    }
}

#Preview {
    PasswordRowView(passwordItem: PasswordItem(id: "", website: "", username: "", password: ""))
}
