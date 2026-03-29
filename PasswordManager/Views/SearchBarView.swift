//
//  SearchBarView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 02/01/26.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View{
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(.systemGray))
            
            TextField("Search", text: $searchText)
        }
        .padding(.leading, 5)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray5))
        )
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
