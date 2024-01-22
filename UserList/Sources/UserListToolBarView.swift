//
//  UserListToolBarView.swift
//  UserList
//
//  Created by Tristan Géhanne on 22/01/2024.
//

import SwiftUI

struct UserListToolBarView: View {
    @StateObject var viewModel = UserListViewModel()
    var body: some View {
        Picker(selection: $viewModel.isGridView, label: Text("Display")) {
            Image(systemName: "rectangle.grid.1x2.fill")
                .tag(true)
                .accessibilityLabel(Text("Grid view"))
            Image(systemName: "list.bullet")
                .tag(false)
                .accessibilityLabel(Text("List view"))
        }
        .pickerStyle(SegmentedPickerStyle())
        
        Button(action: {
            viewModel.reloadUsers()
        }) {
            Image(systemName: "arrow.clockwise")
                .imageScale(.large)
        }
    }
}

#Preview {
    UserListToolBarView()
}
