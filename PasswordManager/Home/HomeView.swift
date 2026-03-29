//
//  HomeView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 02/01/26.
//

import SwiftUI

struct HomeView: View {
    @State var searchText: String = ""
    @State var showAddPasswordView: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            SearchBarView(searchText: $viewModel.searchtext)
                .padding(.horizontal)
            
            ScrollView {
                ForEach(viewModel.filteredAndSortedPasswordItems, id: \.self) { item in
                    NavigationLink(value: item) {
                        PasswordRowView(passwordItem: item,
                                        shouldShowBottomSeparator: item == viewModel.filteredAndSortedPasswordItems.last)
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            .navigationDestination(for: PasswordItem.self) { item in
                if let index = viewModel.passwordItem.firstIndex(where: {$0.id == item.id}) {
                    EditAndDetailPasswordView(passwordItem: $viewModel.passwordItem[index])
                        .padding()
                }
            }
            .safeAreaInset(edge: .bottom){
                BottomView {
                    showAddPasswordView = true
                }
            }
            .navigationTitle("All")
        }
        .sheet(isPresented: $showAddPasswordView) {
            AddPasswordView()
                .padding()
        }
    }
}

#Preview {
    HomeView(searchText: "")
        .environmentObject(ViewModel(manager: KeychainManager()))
}
