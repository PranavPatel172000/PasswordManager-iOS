//
//  BottomView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 04/01/26.
//

import SwiftUI

struct BottomView: View {
    
    var addTapHandler: () -> Void
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack{
            Menu {
                Section {
                    Picker("Order", selection: $viewModel.selectedSortDirection) {
                        Label(PasswordSortDirection.ascending.label, systemImage: PasswordSortDirection.ascending.iconName)
                            .tag(PasswordSortDirection.ascending)
                        
                        Label(PasswordSortDirection.descending.label, systemImage: PasswordSortDirection.descending.iconName)
                            .tag(PasswordSortDirection.descending)
                    }
                    .pickerStyle(.inline)
                    
                    Divider()
                    
                    Picker("Sort By", selection: $viewModel.selectedSortKey) {
                        ForEach(PasswordSortKey.allCases) { key in
                            Label(key.label, systemImage: key.iconName)
                                .tag(key)
                        }
                    }
                    .pickerStyle(.inline)
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                                    .modifier(buttonModifier())
            }
            .frame(height: 30)
            .padding()
            
            Spacer()
            //Total Item
            Text("\(viewModel.passwordItem.count) Items")
                .font(.footnote)
                .fontWeight(.semibold)
            
            Spacer()
            // Add item button
            Button {
                print("Add item Pressed")
                addTapHandler()
            } label: {
                Image(systemName: "plus")
                    .modifier(buttonModifier())
            }
            .padding()
        }
        .background(Color.white)
        .padding(.horizontal)
    }
}

struct buttonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.black)
            .imageScale(.large)
    }
}

#Preview {
    BottomView(addTapHandler: {})
        .environmentObject(ViewModel(manager: KeychainManager()))
}
