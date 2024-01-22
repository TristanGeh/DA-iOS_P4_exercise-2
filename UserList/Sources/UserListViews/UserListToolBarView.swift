//
//  UserListToolBarView.swift
//  UserList
//
//  Created by Tristan Géhanne on 22/01/2024.
//

import SwiftUI

struct UserListToolBarView: View {
    @Binding var isGridView: Bool
        var reloadButton: () -> Void

        var body: some View {
                Picker(selection: $isGridView, label: Text("Display")) {
                    Image(systemName: "rectangle.grid.1x2.fill")
                        .tag(true)
                        .accessibilityLabel(Text("Grid view"))
                    Image(systemName: "list.bullet")
                        .tag(false)
                        .accessibilityLabel(Text("List view"))
                }
                .pickerStyle(SegmentedPickerStyle())

                Button(action: reloadButton) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
            }
        }


